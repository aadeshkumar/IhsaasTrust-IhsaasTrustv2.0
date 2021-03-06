﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace Adoofy
{
    public static class ExtensionMethods
    {
        public static string FormatMethodNameAsTitle(this string methodName)
        {
            string newString = "";
            foreach (char c in methodName)
            {
                if (char.IsUpper(c) && newString != "")
                {
                    newString += " ";
                }
                newString = newString + c.ToString();
            }
            return newString;
        }
        public static string ToHex(this byte[] bytes, bool upperCase)
        {
            StringBuilder result = new StringBuilder(bytes.Length * 2);

            for (int i = 0; i < bytes.Length; i++)
                result.Append(bytes[i].ToString(upperCase ? "X2" : "x2"));

            return result.ToString();
        }
        public static byte[] GetBytes(this string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }
        public static string ParseDescription(this string description)
        {
            if (!string.IsNullOrEmpty(description) && description.Contains("<<"))
            {
                string link = description.Substring(description.IndexOf("<<"), (description.IndexOf(">>") - description.IndexOf("<<")) + 2);
                string apiName = link.Replace("<<", "");
                if (apiName.Contains("[["))
                {
                    apiName = apiName.Replace("[[", "");
                    apiName = apiName.Replace("]]>>", "");
                    description = description.Replace(link, string.Format("<a href='{0}' target='_blank'>here</a>", apiName));
                }
                else
                {
                    apiName = apiName.Replace(">>", "");
                    description = description.Replace(link, string.Format("<a href='#{0}'>{1}</a>", apiName, apiName.Replace("-", " ")));
                }
            }
            while (!string.IsNullOrEmpty(description) && description.Contains("<<"))
            {
                description = description.ParseDescription();
            }
            return description;
        }

        public static string UpdateVideoDimension(this string source)
        {
            if (!(Regex.IsMatch(source, "<embed(.*)width=\"(\\d+)\"") || Regex.IsMatch(source, "<embed(.*)style=\"width: \\d+px\"")))
            {
                source = source.Replace("<embed", "<embed width=\"400\" ");
            }

            if (!(Regex.IsMatch(source, "<embed(.*)height=\"(\\d+)\"") || Regex.IsMatch(source, "<embed(.*)style=\"height: \\d+px\"")))
            {
                source = source.Replace("<embed", "<embed height=\"270\" ");
            }

            //string toBeReturned = Regex.Replace(source, "<embed(.*)width=\"(\\d+)\"", "<embed$1width=\"400\"");
            //toBeReturned = Regex.Replace(toBeReturned, "<embed(.*)height=\"(\\d+)\"", "<embed$1height=\"270\"");
            //toBeReturned = Regex.Replace(toBeReturned, "<embed(.*)style=\"width: \\d+px; height: \\d+px\"", "<embed$1");
            //return toBeReturned;

            string toBeReturned = Regex.Replace(source, "<embed(.*)style=\"width: \\d+px; height: \\d+px\"", "<embed$1");
            return toBeReturned;

        }

        public static string AddPreviewImageTagForSteamer2(this string source)
        {
            //source = source.Replace("<img ", "<img class=\"preview-noshow\" alt=\"\" style=\"max-width:536px;max-height:536px;\" ");
            source = source.Replace("<img ", "<img class=\"preview-noshow\" alt=\"\" onclick=\"javascript:SetMeClickable(this)\" ");
            return source;
        }

        public static string RemoveExtraCarriageReturns(this string source)
        {
            source = Regex.Replace(source, "(<p>&nbsp;</p>)", " ");
            source = Regex.Replace(source, "(\n){2,}", "\n");
            return source;
        }

        public static string AddPreviewImageTag(this string source)
        {
            source = source.Replace("<img ", "<img class=\"preview\" alt=\"\" style=\"max-width:150px;max-height:113px;\" ");
            return source;
        }
        public static string ToMD5Hash(this string input)
        {
            // step 1, calculate MD5 hash from input
            MD5 md5 = System.Security.Cryptography.MD5.Create();
            byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
            byte[] hash = md5.ComputeHash(inputBytes);

            // step 2, convert byte array to hex string
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString();
        }
        private const string KEY = "ARG@PLIS";
        private const string IV = "HUN@IDIS";
        public static string Encrypt(this string text)
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

    }

    public class RowColumn
    {
        public int Row { get; set; } = 0;
        public int Column { get; set; } = 0;
    }
}