// MainForm.cs
//
// Programmed by Machiavellian of iRO Chaos
//
// Description:
// This file contains partial code for the MainForm class object, which is
// used as the graphical user interface for the AzzyAI configuration
// utility.

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AzzyAIConfig
{
    public partial class MainForm : Form
    {
        // Custom controls for H_Config and M_Config - use lazy loading
        private HomConf _hconf = null;
        private MerConf _mconf = null;
        private bool _initialized = false;

        // Lazy properties
        private HomConf HomunculusConfig
        {
            get
            {
                if (_hconf == null)
                    _hconf = new HomConf();
                return _hconf;
            }
        }

        private MerConf MercenaryConfig
        {
            get
            {
                if (_mconf == null)
                    _mconf = new MerConf();
                return _mconf;
            }
        }

        public MainForm()
        {
            // Pregenerated designer code
            InitializeComponent();
            
            // Load the AzzyAI icon for window and taskbar
            try
            {
                this.Icon = new System.Drawing.Icon("azzyai.ico");
            }
            catch
            {
                // Fallback: If azzyai.ico is not found, try to load from application directory
                try
                {
                    string iconPath = System.IO.Path.Combine(System.AppDomain.CurrentDomain.BaseDirectory, "azzyai.ico");
                    this.Icon = new System.Drawing.Icon(iconPath);
                }
                catch
                {
                    // If icon cannot be loaded, continue without it (will use default Windows icon)
                }
            }
        }

        void SaveChanges()
        {
            // Save the configurations only if they were initialized
            if (_hconf != null) _hconf.Save();
            if (_mconf != null) _mconf.Save();
            homTactControl1.Save();
            merTactControl1.Save();
            extraControl1.Save();
            pvpTactControl1.Save();
            m_PvpTactControl1.Save();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            // Delay initialization to improve startup performance
            // The data will be loaded when tabs are first accessed
            
            // Hook up the tab control event handler
            var tabControls = this.Controls.Find("tabControl1", true);
            if (tabControls.Length > 0 && tabControls[0] is TabControl)
            {
                var tabControl = (TabControl)tabControls[0];
                tabControl.SelectedIndexChanged += TabControl_SelectedIndexChanged;
            }
        }

        protected override void SetVisibleCore(bool value)
        {
            // Perform one-time initialization when the form becomes visible
            if (value && !_initialized)
            {
                InitializeData();
                _initialized = true;
            }
            base.SetVisibleCore(value);
        }

        private void InitializeData()
        {
            // Initialize only the visible tab's data
            var tabControls = this.Controls.Find("tabControl1", true);
            if (tabControls.Length == 0) return;
            
            var selectedTab = ((TabControl)tabControls[0]).SelectedTab;
            
            if (selectedTab != null && selectedTab.Text == "Homunculus")
            {
                // Initialize the homunculus tab data
                if (homunculusConfigControl != null)
                {
                    homunculusConfigControl.SelectedObject = HomunculusConfig;
                }
            }
            else if (selectedTab != null && selectedTab.Text == "Mercenary")
            {
                // Initialize the mercenary tab data
                if (propertyGridMercenary != null)
                {
                    propertyGridMercenary.SelectedObject = MercenaryConfig;
                }
            }
        }

        private void TabControl_SelectedIndexChanged(object sender, EventArgs e)
        {
            var tabControl = sender as TabControl;
            if (tabControl == null || tabControl.SelectedTab == null) return;

            // Load data for the selected tab on demand
            switch (tabControl.SelectedTab.Text)
            {
                case "Homunculus":
                    if (homunculusConfigControl != null && 
                        homunculusConfigControl.SelectedObject == null)
                    {
                        homunculusConfigControl.SelectedObject = HomunculusConfig;
                    }
                    break;
                case "Mercenary":
                    if (propertyGridMercenary != null && 
                        propertyGridMercenary.SelectedObject == null)
                    {
                        propertyGridMercenary.SelectedObject = MercenaryConfig;
                    }
                    break;
            }
        }

        private void ConfigChanged(object sender, EventArgs e)
        {
            // Check if buttonApply is not enabled
            if (!buttonApply.Enabled)
            {
                // Enable buttonApply
                buttonApply.Enabled = true;
            }

            // Check if the applySettingsToolStripMenuItem is not enabled
            if (!applySettingsToolStripMenuItem.Enabled)
            {
                // Enable applySettingsToolStripMenuItem
                applySettingsToolStripMenuItem.Enabled = true;
            }

            // Check if the revertToolStripMenuItem is not enabled
            if (!revertToolStripMenuItem.Enabled)
            {
                // Enable reverToolStripMenuItem
                revertToolStripMenuItem.Enabled = true;
            }

            // Check if the resetToDefaultsToolStripMenuItem is not enabled
            if (!resetToDefaultsToolStripMenuItem.Enabled)
            {
                // Enable resetToDefaultsToolStripMenuItem
                resetToDefaultsToolStripMenuItem.Enabled = true;
            }
        }

        private void homunculusConfigControl_PropertyValueChanged(object sender, EventArgs e)
        {
            // Check if buttonApply is not enabled
            if (!buttonApply.Enabled)
            {
                // Enable buttonApply
                buttonApply.Enabled = true;
            }

            // Check if the applySettingsToolStripMenuItem is not enabled
            if (!applySettingsToolStripMenuItem.Enabled)
            {
                // Enable applySettingsToolStripMenuItem
                applySettingsToolStripMenuItem.Enabled = true;
            }

            // Check if the revertToolStripMenuItem is not enabled
            if (!revertToolStripMenuItem.Enabled)
            {
                // Enable reverToolStripMenuItem
                revertToolStripMenuItem.Enabled = true;
            }

            // Check if the resetToDefaultsToolStripMenuItem is not enabled
            if (!resetToDefaultsToolStripMenuItem.Enabled)
            {
                // Enable resetToDefaultsToolStripMenuItem
                resetToDefaultsToolStripMenuItem.Enabled = true;
            }
        }

        private void propertyGridHomunculus_PropertyValueChanged(object s, PropertyValueChangedEventArgs e)
        {
            // Check if buttonApply is not enabled
            if (!buttonApply.Enabled)
            {
                // Enable buttonApply
                buttonApply.Enabled = true;
            }

            // Check if the applySettingsToolStripMenuItem is not enabled
            if (!applySettingsToolStripMenuItem.Enabled)
            {
                // Enable applySettingsToolStripMenuItem
                applySettingsToolStripMenuItem.Enabled = true;
            }

            // Check if the revertToolStripMenuItem is not enabled
            if (!revertToolStripMenuItem.Enabled)
            {
                // Enable reverToolStripMenuItem
                revertToolStripMenuItem.Enabled = true;
            }

            // Check if the resetToDefaultsToolStripMenuItem is not enabled
            if (!resetToDefaultsToolStripMenuItem.Enabled)
            {
                // Enable resetToDefaultsToolStripMenuItem
                resetToDefaultsToolStripMenuItem.Enabled = true;
            }
        }

        private void propertyGridMercenary_PropertyValueChanged(object s, PropertyValueChangedEventArgs e)
        {
            // Check if buttonApply is not enabled
            if (!buttonApply.Enabled)
            {
                // Enable buttonApply
                buttonApply.Enabled = true;
            }

            // Check if the applySettingsToolStripMenuItem is not enabled
            if (!applySettingsToolStripMenuItem.Enabled)
            {
                // Enable applySettingsToolStripMenuItem
                applySettingsToolStripMenuItem.Enabled = true;
            }

            // Check if the revertToolStripMenuItem is not enabled
            if (!revertToolStripMenuItem.Enabled)
            {
                // Enable reverToolStripMenuItem
                revertToolStripMenuItem.Enabled = true;
            }

            // Check if the resetToDefaultsToolStripMenuItem is not enabled
            if (!resetToDefaultsToolStripMenuItem.Enabled)
            {
                // Enable resetToDefaultsToolStripMenuItem
                resetToDefaultsToolStripMenuItem.Enabled = true;
            }
        }

        private void buttonQuit_Click(object sender, EventArgs e)
        {
            // Check if buttonApply is enabled
            if (buttonApply.Enabled)
            {
                // Popup a message to check if the user would like to save the configurations
                System.Windows.Forms.DialogResult result = MessageBox.Show("Would you like to save these configuration settings?", "Message", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question);

                // Check if the result from the message box is yes
                if (result == System.Windows.Forms.DialogResult.Yes)
                {
                    // Save the configuration changes
                    SaveChanges();

                    // Close the window
                    Close();
                }

                // If the result from the message box is no
                else if (result == System.Windows.Forms.DialogResult.No)
                {
                    // Close the window
                    Close();
                }
            }

            // Close the window
            Close();
        }

        private void buttonApply_Click(object sender, EventArgs e)
        {
            // Save the configuration changes
            SaveChanges();

            // Disable the buttonApply
            buttonApply.Enabled = false;

            // Disable the applySettingsToolStripMenuItem
            applySettingsToolStripMenuItem.Enabled = false;

            // Disable the reverToolStripMenuItem
            revertToolStripMenuItem.Enabled = false;
        }

        private void revertToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Revert the configurations only if they were initialized
            if (_hconf != null)
            {
                _hconf.Revert();
                homunculusConfigControl.Refresh();
            }
            if (_mconf != null)
            {
                _mconf.Revert();
                propertyGridMercenary.Refresh();
            }
        }

        private void resetToDefaultsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Reset the configurations to defaults only if they were initialized
            if (_hconf != null)
            {
                _hconf.SetDefaults();
                homunculusConfigControl.Refresh();
            }
            if (_mconf != null)
            {
                _mconf.SetDefaults();
                propertyGridMercenary.Refresh();
            }
        }

        private void documentationToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Check if the documentation file exists
            if (System.IO.File.Exists("Documentation.pdf"))
            {
                try
                {
                    // Open PDF explicitly with default web browser
                    string pdfPath = System.IO.Path.GetFullPath("Documentation.pdf");
                    string fileUrl = "file:///" + pdfPath.Replace('\\', '/');
                    
                    // Force open with default browser using rundll32
                    System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo()
                    {
                        FileName = "rundll32.exe",
                        Arguments = $"url.dll,FileProtocolHandler \"{fileUrl}\"",
                        UseShellExecute = true
                    });
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Could not open documentation: {ex.Message}", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            // If the documentation file does not exist
            else
            {
                // Popup an error message for the documentation file
                MessageBox.Show("Documentation file could not be found.", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Create a new AzzyAIAboutBox
            //AzzyAIAboutBox about = new AzzyAIAboutBox();
            // Show the about box
            //about.ShowDialog();
            MessageBox.Show("Azzy AI v1.54\nAI written by Dr. Azzy\nGUI written by Machiavellian with multiple extensions by Dr. Azzy\n(C) 2009-2014\n\nIcon by Kami Kali","AzzyAI 1.54", MessageBoxButtons.OK);
        }

        private void homunculusSettingsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Create a new open file dialog box
            OpenFileDialog ofd = new OpenFileDialog();

            // Turn on validate names
            ofd.ValidateNames = true;

            // Add a filter for lua files
            ofd.Filter = "(*.lua)|*.lua";

            // Set the open file dialog box title to "Import homunculus settings."
            ofd.Title = "Import homunculus settings.";

            // Show the dialog and check if the result is OK
            if (ofd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Open the file
                HomunculusConfig.Open(ofd.FileName);

                // Update the homunculusConfigControl values
                homunculusConfigControl.UpdateData();
            }
        }

        private void mercenarySettingsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Create a new open file dialog box
            OpenFileDialog ofd = new OpenFileDialog();

            // Turn on validate names
            ofd.ValidateNames = true;

            // Add a filter for lua files
            ofd.Filter = "(*.lua)|*.lua";

            // Set the open file dialog box title to "Import mercenary settings."
            ofd.Title = "Import mercenary settings.";

            // Show the dialog and check if the result is OK
            if (ofd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Open the file
                MercenaryConfig.Open(ofd.FileName);

                // Update the propertyGridHomunculus values
                propertyGridMercenary.Update();
            }
        }

        private void homunculusTacticsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Create a new open file dialog box
            OpenFileDialog ofd = new OpenFileDialog();

            // Turn on validate names
            ofd.ValidateNames = true;

            // Add a filter for lua files
            ofd.Filter = "(*.lua)|*.lua";

            // Set the open file dialog box title to "Import homunculus tactics."
            ofd.Title = "Import homunculus tactics.";

            // Show the dialog and check if the result is OK
            if (ofd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Open the file
                homTactControl1.Open(ofd.FileName);
            }
        }

        private void mercenaryTacticsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Create a new open file dialog box
            OpenFileDialog ofd = new OpenFileDialog();

            // Turn on validate names
            ofd.ValidateNames = true;

            // Set the open file dialog box title to "Import mercenary tactics."
            ofd.Title = "Import mercenary tactics.";

            // Add a filter for lua files
            ofd.Filter = "(*.lua)|*.lua";

            // Show the dialog and check if the result is OK
            if (ofd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Open the file
                merTactControl1.Open(ofd.FileName);
            }
        }

        private void homunculusSettingsToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            // Create a new save file dialog box
            SaveFileDialog sfd = new SaveFileDialog();

            // Turn on validate names
            sfd.ValidateNames = true;

            // Set the open file dialog box title to "Export homunculus settings."
            sfd.Title = "Export homunculus settings.";

            // Add a filter for lua files
            sfd.Filter = "(*.lua)|*.lua";

            // Show the dialog and check if the result is OK
            if (sfd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Save the file
                _hconf.Save(sfd.FileName);
            }
        }

        private void mercenarySettingsToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            // Create a new save file dialog box
            SaveFileDialog sfd = new SaveFileDialog();

            // Turn on validate names
            sfd.ValidateNames = true;

            // Set the open file dialog box title to "Export mercenary settings."
            sfd.Title = "Export mercenary settings.";

            // Add a filter for lua files
            sfd.Filter = "(*.lua)|*.lua";

            // Show the dialog and check if the result is OK
            if (sfd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Save the file
                _mconf.Save(sfd.FileName);
            }
        }

        private void homunculusTacticsToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            // Create a new save file dialog box
            SaveFileDialog sfd = new SaveFileDialog();

            // Turn on validate names
            sfd.ValidateNames = true;

            // Set the open file dialog box title to "Export homunculus tactics."
            sfd.Title = "Export homunculus tactics.";

            // Add a filter for lua files
            sfd.Filter = "(*.lua)|*.lua";

            // Show the dialog and check if the result is OK
            if (sfd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Save the file
                homTactControl1.Save(sfd.FileName);
            }
        }

        private void mercenaryTacticsToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            // Create a new save file dialog box
            SaveFileDialog sfd = new SaveFileDialog();

            // Turn on validate names
            sfd.ValidateNames = true;

            // Set the open file dialog box title to "Export mercenary tactics."
            sfd.Title = "Export homunculus tactics.";

            // Add a filter for lua files
            sfd.Filter = "(*.lua)|*.lua";

            // Show the dialog and check if the result is OK
            if (sfd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                // Save the file
                merTactControl1.Save(sfd.FileName);
            }
        }

        private void tabPage3_Click(object sender, EventArgs e)
        {

        }

        private void homTactControl1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }


    }
}
