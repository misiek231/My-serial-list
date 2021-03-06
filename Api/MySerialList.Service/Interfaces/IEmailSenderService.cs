﻿using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IEmailSenderService
    {
        Task SendEmailAsync(string email, string subject, string message);
    }
}
