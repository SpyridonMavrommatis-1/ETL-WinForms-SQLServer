namespace DebtorsWinFormsApp
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.unzip = new System.Windows.Forms.Button();
            this.runSSIS = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // unzip
            // 
            this.unzip.Location = new System.Drawing.Point(231, 60);
            this.unzip.Name = "unzip";
            this.unzip.Size = new System.Drawing.Size(75, 23);
            this.unzip.TabIndex = 0;
            this.unzip.Text = "unzip";
            this.unzip.UseVisualStyleBackColor = true;
            this.unzip.Click += new System.EventHandler(this.button1_Click);
            // 
            // runSSIS
            // 
            this.runSSIS.Location = new System.Drawing.Point(231, 145);
            this.runSSIS.Name = "runSSIS";
            this.runSSIS.Size = new System.Drawing.Size(75, 23);
            this.runSSIS.TabIndex = 1;
            this.runSSIS.Text = "runSSIS";
            this.runSSIS.UseVisualStyleBackColor = true;
            this.runSSIS.Click += new System.EventHandler(this.runSSIS_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.runSSIS);
            this.Controls.Add(this.unzip);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button unzip;
        private System.Windows.Forms.Button runSSIS;
    }
}

