using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

/// <summary>
/// Summary description for cls_Md5Js
/// </summary>
public class cls_Md5Js
{
    public cls_Md5Js()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string Md5(string plaintext)
    {
        // Khóa mật khẩu (khóa và iv nên được quản lý an toàn)
        string keyHex = "2b7e151628aed2a6abf7158809cf4f3c";
        string ivHex = "3ad77bb40d7a3660a89ecaf32466ef97";

        byte[] keyBytes = StringToByteArray(keyHex);
        byte[] ivBytes = StringToByteArray(ivHex);

        // Mã hóa chuỗi
        string ciphertext = EncryptAES(plaintext, keyBytes, ivBytes);
        Console.WriteLine("Chuỗi đã mã hóa: " + ciphertext);

        return ciphertext;
    }
    public string EncryptAES(string plaintext, byte[] key, byte[] iv)
    {
        using (Aes aesAlg = Aes.Create())
        {
            aesAlg.Key = key;
            aesAlg.IV = iv;

            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

            using (MemoryStream msEncrypt = new MemoryStream())
            {
                using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                {
                    using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                    {
                        swEncrypt.Write(plaintext);
                    }
                }
                return Convert.ToBase64String(msEncrypt.ToArray());
            }
        }
    }
    public string DecryptAES(string ciphertext, byte[] key, byte[] iv)
    {
        using (Aes aesAlg = Aes.Create())
        {
            aesAlg.Key = key;
            aesAlg.IV = iv;

            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

            using (MemoryStream msDecrypt = new MemoryStream(Convert.FromBase64String(ciphertext)))
            {
                using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                {
                    using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                    {
                        return srDecrypt.ReadToEnd();
                    }
                }
            }
        }
    }

    public byte[] StringToByteArray(string hex)
    {
        int numberChars = hex.Length;
        byte[] bytes = new byte[numberChars / 2];
        for (int i = 0; i < numberChars; i += 2)
        {
            bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
        }
        return bytes;
    }
}