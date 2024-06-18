namespace Domain.Infrastructure;

public class Result<T> : IEquatable<Result<T>>
    {
        private const string DefaultError = "Unknown error";

        public override string ToString()
        {
            return IsSuccessful ? $"Successful result of {Value}" : $"Failed result with {ErrorMessage}";
        }

        public static Result<T> Successful(T value)
        {
            return new Result<T>
            {
                Value = value,
                HasValue = true,
                IsSuccessful = true
            };
        }

        public static Result<T> Failed(string errorMessage)
        {
            return new Result<T>
            {
                IsSuccessful = false,
                ErrorMessage = errorMessage ?? throw new ArgumentNullException(nameof(errorMessage))
            };
        }

        public static Result<T> FailedWith(T failValue, string errorMessage)
        {
            return new Result<T>
            {
                Value = failValue,
                HasValue = true,
                IsSuccessful = false,
                ErrorMessage = errorMessage ?? throw new ArgumentNullException(nameof(errorMessage))
            };
        }

        private string? errorMessage;

        public bool HasValue { get; private set; }
        public T Value { get; private set; }
        public bool IsSuccessful { get; private set; }
        public bool IsFailed => !IsSuccessful;

        public string ErrorMessage
        {
            get => (IsFailed && errorMessage == null ? DefaultError : errorMessage)!;
            private set => errorMessage = value;
        }

        public Result<T> EnsureOk()
        {
            if (IsSuccessful)
                return this;

            throw new Exception(ErrorMessage);
        }

        public void Deconstruct(out T result, out string error)
        {
            result = Value;
            error = ErrorMessage;
        }

        public void Deconstruct(out bool isSuccessful, out T result, out string error)
        {
            result = Value;
            error = ErrorMessage;
            isSuccessful = IsSuccessful;
        }

        public static implicit operator Result<T>(T success)
        {
            return Successful(success);
        }

        public static implicit operator Result<T>(string failure)
        {
            return Failed(failure);
        }

        public bool Equals(Result<T> other)
        {
            if (IsSuccessful && other.IsSuccessful)
                return EqualityComparer<T>.Default.Equals(Value, other.Value);
            return errorMessage == other.errorMessage;
        }

        public override bool Equals(object obj)
        {
            return obj is Result<T> other && Equals(other);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                if (IsSuccessful)
                    return Value?.GetHashCode() ?? 0;
                return errorMessage?.GetHashCode() ?? 0;
            }
        }

        public static bool operator ==(Result<T> left, Result<T> right)
        {
            return left.Equals(right);
        }

        public static bool operator !=(Result<T> left, Result<T> right)
        {
            return !left.Equals(right);
        }
    }