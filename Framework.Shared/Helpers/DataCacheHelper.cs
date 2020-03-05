using ServiceStack.CacheAccess;
using ServiceStack.CacheAccess.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Text;

namespace Framework.Shared.Helpers
{
    interface IDataCache
    {
        void SetData<T>(string cacheKey, T objectToCache, int expireCacheInSecs);
        T GetData<T>(string cacheKey);
        void RemoveEntry(string cacheKey);
        bool ContainsKey(string cacheKey);
    }

    public abstract class DataCache
    {
        protected TimeSpan GetCacheExpirationTimeSpan(int seconds)
        {
            int h, m, s;
            h = m = s = 0;

            if (seconds >= 60)
            {
                m = seconds / 60;

                if (m >= 60)
                {
                    h = m / 60;
                    m = (m % 60);
                }

                s = (seconds % 60);
            }
            else
            {
                s = seconds;
            }

            return (new TimeSpan(h, m, s));
        }
    }

    public class InMemoryDataCache : DataCache, IDataCache
    {
        static NLog.Logger logger = NLog.LogManager.GetCurrentClassLogger();

        private static readonly InMemoryDataCache _singleton = new InMemoryDataCache();
        public static InMemoryDataCache Instance
        {
            get { return (_singleton); }
        }
        protected InMemoryDataCache()
        {
        }

        public void SetData<T>(string cacheKey, T objectToCache, int expireCacheInSecs)
        {
            // MSDN: Entry is updated if it exists
            MemoryCache.Default.Set(new CacheItem(cacheKey,
                                                  objectToCache),
                                    GetDataCacheItemPolicy(expireCacheInSecs));
        }
        public T GetData<T>(string cacheKey)
        {
            T result = default(T);

            result = (T) MemoryCache.Default[cacheKey];

            return result;
        }
        public void RemoveEntry(string cacheKey)
        {
            if (ContainsKey(cacheKey))
            {
                MemoryCache.Default.Remove(cacheKey);
            }
        }
        public bool ContainsKey(string cacheKey)
        {
            bool result = false;

            if (MemoryCache.Default.Contains(cacheKey))
            {
                result = true;
            }

            return (result);
        }

        private static CacheItemPolicy GetDataCacheItemPolicy(int absoluteExpirationInSeconds)
        {
            CacheItemPolicy cip = new CacheItemPolicy();
            try
            {
                cip.AbsoluteExpiration = new DateTimeOffset(DateTime.Now.AddSeconds(absoluteExpirationInSeconds));
            }
            catch (Exception ex)
            {
                logger.ErrorException(string.Empty, ex);
                throw;
            }
            return (cip);
        }

        public List<string> GetAllCacheKeys()
        {
            List<string> CacheKeys = new List<string>();
            foreach(var item in MemoryCache.Default)
            {
                CacheKeys.Add(item.Key.ToString());
            }
            return CacheKeys;
        }
    }
}
