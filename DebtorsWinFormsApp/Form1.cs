using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Ionic.Zip;

namespace DebtorsWinFormsApp
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // path προς το zip
                string zipFilePath = @"C:\Users\Spiri\Downloads\SoftwareDeveloperExercise\SoftwareDeveloperExercise\Files.zip";

                // path όπου θα γίνει η αποσυμπίεση
                string extractPath = @"C:\Users\Spiri\Downloads\SoftwareDeveloperExercise\SoftwareDeveloperExercise\ExtractedFiles.zip";

                using (ZipFile zip = ZipFile.Read(zipFilePath))
                {
                    zip.Password = "FirstCall13"; 
                    foreach (ZipEntry entry in zip)
                    {
                        entry.Extract(extractPath, ExtractExistingFileAction.OverwriteSilently);
                    }
                }

                MessageBox.Show("Το unzip ολοκληρώθηκε επιτυχώς!", "Success",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Σφάλμα: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void runSSIS_Click(object sender, EventArgs e)
        {
            try
            {
                // path στο SSIS package (dtproj ή .dtsx)
                string packagePath = @"C:\Users\Spiri\OneDrive\Desktop\DebtorsWinFormsApp\Step2_RunSSIS\Integration Services Project1\Package.dtsx";

                // Εκτελεί το SSIS package μέσω dtexec
                System.Diagnostics.Process process = new System.Diagnostics.Process();
                process.StartInfo.FileName = "dtexec";
                process.StartInfo.Arguments = $"/f \"{packagePath}\"";
                process.StartInfo.UseShellExecute = false;
                process.StartInfo.RedirectStandardOutput = true;
                process.Start();

                string output = process.StandardOutput.ReadToEnd();
                process.WaitForExit();

                MessageBox.Show("Το SSIS package εκτελέστηκε επιτυχώς!\n\n" + output,
                    "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Σφάλμα κατά την εκτέλεση του SSIS: " + ex.Message,
                    "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
