﻿namespace Web.Dtos.Request;

public class PaginationDto
{
    public int Offset { get; set; } = 0;

    public int Limit { get; set; } = 5;
}