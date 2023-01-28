using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            int Targetcount = 50;
            int Nodecount = 250;
            int Mapsize = 300;
            int RS = 10;
            int Final = 28;
            int Maxborder = 25;
            int BorderCount = 0;

            Console.Write("Node Count : ");
            Nodecount = Convert.ToInt32(Console.ReadLine());
            Console.Write("Target Count : ");
            Targetcount = Convert.ToInt32(Console.ReadLine());
            Console.Write("Map Size : ");
            Mapsize = Convert.ToInt32(Console.ReadLine());
            Console.Write("Rs : ");
            RS = Convert.ToInt32(Console.ReadLine());
            Console.Write("Final : ");
            Final = Convert.ToInt32(Console.ReadLine());
            //Console.Write("Max border : ");
            //Maxborder = Convert.ToInt32(Console.ReadLine());

            int[] TargetsX = new int[Targetcount];
            int[] TargetsY = new int[Targetcount];
            int[] OnNode = new int[Targetcount];
            int[] MapX = new int[Nodecount];
            int[] MapY = new int[Nodecount];
            int[] Border = new int[Nodecount];
            double[] Distances = new double[Nodecount];
            double[] KDistances = new double[Nodecount];
            Random rnd = new Random();

            for (int i = 0; i < (Mapsize/RS); i++)
            {
                using (StreamWriter sw2 = File.AppendText("./BORDER.TXT"))
                {
                    int X = rnd.Next(0, RS);
                    int Y = rnd.Next((RS*i), (RS *(i+1)));
                    sw2.WriteLine("{0} {1}", X, Y);
                }
            }

            for (int i = 0; i < (Mapsize / RS); i++)
            {
                using (StreamWriter sw2 = File.AppendText("./BORDER.TXT"))
                {
                    int X = rnd.Next((RS * i), (RS * (i + 1)));
                    int Y = rnd.Next(0, RS);
                    sw2.WriteLine("{0} {1}", X, Y);
                }
            }
            for (int i = 0; i < (Mapsize / RS); i++)
            {
                using (StreamWriter sw2 = File.AppendText("./BORDER.TXT"))
                {
                    int X = rnd.Next(Mapsize - RS, Mapsize);
                    int Y = rnd.Next((RS * i), (RS * (i + 1)));
                    sw2.WriteLine("{0} {1}", X, Y);
                }
            }
            for (int i = 0; i < (Mapsize / RS); i++)
            {
                using (StreamWriter sw2 = File.AppendText("./BORDER.TXT"))
                {
                    int X = rnd.Next((RS * i), (RS * (i + 1)));
                    int Y = rnd.Next(Mapsize - RS, Mapsize);
                    sw2.WriteLine("{0} {1}", X, Y);
                }
            }

            for (int i = 0; i < Nodecount; i++)
            {
                using (StreamWriter sw2 = File.AppendText("./MAP.TXT"))
                {
                    int X = rnd.Next(0, Mapsize);
                    int Y = rnd.Next(0, Mapsize);
                    sw2.WriteLine("{0} {1}", X, Y);
                    MapX[i] = X;
                    MapY[i] = Y;
                }
            }
            for (int i = 0; i < Nodecount; i++)
            {
                if (MapX[i] < RS || MapX[i] > (Mapsize - RS) || MapY[i] < RS || MapY[i] > (Mapsize - RS))
                {
                    Border[i] = i;
                    BorderCount++;
                }
            }
            for (int i = 0; i < BorderCount; i++)
            {
                using (StreamWriter sw2 = File.AppendText("./BORDER2.TXT"))
                {
                    sw2.WriteLine("{0} {1}", MapX[Border[i]], MapY[Border[i]]);
                }
            }
            for (int i = 0; i < Targetcount; i++)
            {
                using (StreamWriter sw2 = File.AppendText("./TARGET.TXT"))
                {
                    int X = rnd.Next(0, Mapsize);
                    int Y = rnd.Next(0, Mapsize);
                    sw2.WriteLine("{0} {1}", X, Y);
                    TargetsX[i] = X;
                    TargetsY[i] = Y;
                }
            }
            for (int i = 0; i < Targetcount; i++)
            {
                for (int k = 0; k < Nodecount; k++)
                {
                    Distances[k] = Math.Pow(Math.Pow((MapX[k] - TargetsX[i]), 2) + Math.Pow((MapY[k] - TargetsY[i]), 2), 0.5); 
                }
                double max1Value = Distances.Min();
                int max1Index = Distances.ToList().IndexOf(max1Value);
                OnNode[i] = max1Index;
                
            }
            for (int i = 0; i < Final; i++)
            {
                int X = rnd.Next(0, Targetcount);
                using (StreamWriter sw2 = File.AppendText("./ON.TXT"))
                {
                    sw2.WriteLine("{0} {1}", MapX[OnNode[X]], MapY[OnNode[X]]);
                }
            }
        }
    }
}
