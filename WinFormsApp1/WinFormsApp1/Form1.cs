using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinFormsApp1
{
    public partial class Form1 : Form
    {
        string filePath;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.InitialDirectory = "C:\\";

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    //Get the path of specified file
                    filePath = openFileDialog.FileName;
                    txtFilePath.Text = filePath;
                }
            }
        }

        private void btnAnalyse_Click(object sender, EventArgs e)
        {
            using (Bitmap img = new Bitmap(txtFilePath.Text)) {
                string output = "";
                for (int i = 0; i < 224; i++)
                {
                    for (int j = 0; j < 256; j++)
                    {
                        Color pixel = img.GetPixel(j, i);
                        string color;
                        if (pixel.Name == "0")
                        {
                            output += ", TRANS_CC";
                        }
                        else {
                            color = pixel.Name.Substring(2);
                            switch (color)
                            {
                                case "000000":
                                    output += ", x\"1\"";
                                    break;
                                case "ffffff":
                                    output += ", x\"2\"";
                                    break;
                                case "00a2e8":
                                    output += ", x\"3\"";
                                    break;
                                case "ed1a2c":
                                    output += ", x\"4\"";
                                    break;
                                case "c85086":
                                    output += ", x\"5\"";
                                    break;
                                case "f7ab79":
                                    output += ", x\"6\"";
                                    break;
                                case "b4e61d":
                                    output += ", x\"7\"";
                                    break;
                                case "0c6624":
                                    output += ", x\"8\"";
                                    break;
                                case "22b14d":
                                    output += ", x\"9\"";
                                    break;
                                case "8a5132":
                                    output += ", x\"A\"";
                                    break;
                                case "ff7f2f":
                                    output += ", x\"B\"";
                                    break;
                                case "fff200":
                                    output += ", x\"C\"";
                                    break;
                                case "7a767a":
                                    output += ", x\"D\"";
                                    break;
                                case "2121B8":
                                    output += ", x\"E\"";
                                    break;
                                default:
                                    output += ", x\"F\"";
                                    break;
                            }
                        }
                    }
                    output += "\n";
                }
                richTextBox1.Text = output;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            using (Bitmap img = new Bitmap(txtFilePath.Text))
            {
                string output = "";
                for (int i = 0; i < img.Width; i++)
                {
                    for (int j = 0; j < img.Height; j++)
                    {
                        Color pixel = img.GetPixel(j, i);
                        string color;
                        if (pixel.Name == "0")
                        {
                            output += ", TRANS_CC";
                        }
                        else
                        {
                            color = pixel.Name.Substring(2);
                            switch (color)
                            {
                                case "000000":
                                    output += ", NOIR_CC";
                                    break;
                                case "ffffff":
                                    output += ", BLANC_CC";
                                    break;
                                case "00a2e8":
                                    output += ", WATER";
                                    break;
                                case "ed1a2c":
                                    output += ", ROUGE_CC";
                                    break;
                                case "c85086":
                                    output += ", ROSE_CC";
                                    break;
                                case "f7ab79":
                                    output += ", BEIGE_CC";
                                    break;
                                case "b4e61d":
                                    output += ", LIME_CC";
                                    break;
                                case "0c6624":
                                    output += ", VERT2_CC";
                                    break;
                                case "22b14d":
                                    output += ", VERT1_CC";
                                    break;
                                case "8a5132":
                                    output += ", BRUN_CC";
                                    break;
                                case "ff7f2f":
                                    output += ", BRICK";
                                    break;
                                case "fff200":
                                    output += ", DIRT";
                                    break;
                                case "66696b":
                                    output += ", GRIS_CC";
                                    break;
                                default:
                                    output += ", x\"1\"";
                                    break;
                            }
                        }
                    }
                    output += "\n";
                }
                richTextBox1.Text = output;
            }
        }
    }
}
