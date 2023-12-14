namespace Web.Models;

public class PageList<T> : List<T>
{
    public int Offset { get; }
    public int Limit { get; }
    
    public PageList(IEnumerable<T> items, int offset, int limit) : base(items)
    {
        Offset = offset;
        Limit = limit;
    }
}