using System;

namespace Robokassa.Exceptions
{
    public abstract class RobokassaBaseException : Exception
    {
        protected RobokassaBaseException(string message) : base(message)
        {
        }
    }
}