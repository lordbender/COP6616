using System;
using Dotnet.Tpl.Example.Services;

namespace Dotnet.Tpl.Example
{
    class Program
    {
        static void Main(string[] args)
        {
            var matrixService = new MatrixServices();

            matrixService.RunTest(1000);
        }
    }
}
