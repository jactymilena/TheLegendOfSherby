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
                for (int i = 0; i < img.Width; i++)
                {
                    for (int j = 0; j < img.Height; j++)
                    {
                        Color pixel = img.GetPixel(j, i);
                        string color = pixel.Name.Substring(2);
                        switch (color)
                        {
                            case "000000":
                                output += ", x\"1\"";
                                break;
                            case "ffffff":
                                output += ", x\"2\"";
                                break;
                            case "00a2e8":
                                output += ", BLEU1_CC";
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
                                output += ", ORANGE_CC";
                                break;
                            case "fff200":
                                output += ", JAUNE_CC";
                                break;
                            case "66696b":
                                output += ", GRIS_CC";
                                break;
                            default:
                                output += ", x\"1\"";
                                break;
                        }
                    }
                    output += "\n";
                }
                richTextBox1.Text = output;
            }
        }
    }
}
