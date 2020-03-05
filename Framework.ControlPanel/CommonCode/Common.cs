using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace Adoofy.CommonCode
{
    public static class Common
    {
        private const string KEY = "CRY@PTOF";
        private const string IV = "UMA@RFAR";

        public static int UserID { get; set; } = 0;
        public static string DeviceToken { get; set; }

        public static bool IsUserImageValid(string dbImageURL)
        {
            bool valid = true;

            if (dbImageURL.Contains("graph.facebook.com"))
            {
                return valid;
            }

            string googleDefaultPicture = "/photo.jpg";
            string twitterDefaultPicture = "default_profile_image";
            
            List<string> defaultImageURLs = new List<string>();
            defaultImageURLs.Add(googleDefaultPicture);
            defaultImageURLs.Add(twitterDefaultPicture);

            string dbImageUrl = dbImageURL;

            foreach (string defaultUrl in defaultImageURLs)
            {
                if (dbImageUrl.Trim().Contains(defaultUrl.Trim()))
                {
                    valid = false;
                    break;
                }
            }

            return valid;
        }

        public static string DPassword(string password)
        {
            return Decrypt(password);
        }

        public static string EPassword(string password)
        {
            return Encrypt(password);
        }

        private static string Encrypt(string text)
        {
            if (text.Trim().Length == 0)
                return string.Empty;
            byte[] bKey, bIV, bInput;

            bKey = System.Text.Encoding.UTF8.GetBytes(KEY);
            bIV = System.Text.Encoding.UTF8.GetBytes(IV);
            bInput = System.Text.Encoding.UTF8.GetBytes(text);

            MemoryStream memStream = new MemoryStream();

            DES des = new DESCryptoServiceProvider();
            CryptoStream encStream = new CryptoStream(memStream, des.CreateEncryptor(bKey, bIV), CryptoStreamMode.Write);

            encStream.Write(bInput, 0, bInput.Length);
            encStream.FlushFinalBlock();
            string st = Convert.ToBase64String(memStream.ToArray());

            return (st);
        }

        private static string Decrypt(string encText)
        {
            if (encText.Trim().Length == 0)
                return string.Empty;
            byte[] bKey, bIV, bInput;

            bKey = System.Text.Encoding.UTF8.GetBytes(KEY);
            bIV = System.Text.Encoding.UTF8.GetBytes(IV);
            bInput = Convert.FromBase64String(encText);

            MemoryStream memStream = new MemoryStream();

            DES des = new DESCryptoServiceProvider();
            CryptoStream encStream = new CryptoStream(memStream, des.CreateDecryptor(bKey, bIV), CryptoStreamMode.Write);

            encStream.Write(bInput, 0, bInput.Length);
            encStream.FlushFinalBlock();

            return (System.Text.Encoding.UTF8.GetString(memStream.ToArray()));
        }
        public static string GenerateNewPlainPassword()
        {
            return Guid.NewGuid().ToString().Replace("-", string.Empty).Substring(4, 8);
        }
    }
}