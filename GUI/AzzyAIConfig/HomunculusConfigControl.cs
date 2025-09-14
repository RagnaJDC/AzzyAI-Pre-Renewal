using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Windows.Forms;
using AzzyAIConfig.Properties;

namespace AzzyAIConfig
{
    public partial class HomunculusConfigControl : UserControl
    {
        private HomConf _hconf;
        private TabControl tabControl;
        private TextBox searchBox;
        private ComboBox homunculusBaseFilter;
        private Label searchLabel;
        private Label homunculusBaseLabel;
        private TextBox helpTextBox;
        private Label helpLabel;
        private Dictionary<string, FilteredHomConfWrapper> categoryWrappers;
        private bool _isInitialized = false;

        // Variables to track last detected homunculus types
        private string lastHomunculusBase = "";
        
        // File monitoring for htype detection from Lua
        private FileSystemWatcher fileWatcher;
        private Timer fileCheckTimer;
        private readonly string htypeFilePath = Path.Combine(Application.StartupPath, "data", "detected_htype.txt");

        public event EventHandler PropertyValueChanged;

        public HomunculusConfigControl()
        {
            InitializeComponent();
            // Defer heavy initialization until first access
            categoryWrappers = new Dictionary<string, FilteredHomConfWrapper>();
        }

        internal HomConf SelectedObject
        {
            get { return _hconf; }
            set
            {
                _hconf = value;
                if (value != null)
                {
                    EnsureInitialized();
                    // Use BeginInvoke for async UI updates to improve responsiveness
                    // But only if the control handle is created and we're not in design mode
                    if (this.IsHandleCreated && !this.DesignMode)
                    {
                        this.BeginInvoke(new Action(() => RefreshAllTabs()));
                    }
                    else
                    {
                        // If handle not created yet or in design mode, refresh synchronously
                        RefreshAllTabs();
                    }
                }
            }
        }

        private void EnsureInitialized()
        {
            if (!_isInitialized)
            {
                SetupUI();
                SetupFileMonitoring();
                _isInitialized = true;
            }
        }

        private void InitializeComponent()
        {
            this.SuspendLayout();
            
            // 
            // HomunculusConfigControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Name = "HomunculusConfigControl";
            this.Size = new System.Drawing.Size(604, 351);
            
            this.ResumeLayout(false);
        }

        private void SetupUI()
        {
            // Suspend layout during initialization for better performance
            this.SuspendLayout();

            // Create search and filter controls
            searchLabel = new Label
            {
                Text = "Search:",
                Location = new Point(10, 10),
                Size = new Size(50, 20),
                TextAlign = ContentAlignment.MiddleLeft
            };

            searchBox = new TextBox
            {
                Location = new Point(70, 10),
                Size = new Size(150, 20)
            };
            // Defer event handler to avoid triggering during initialization
            
            homunculusBaseLabel = new Label
            {
                Text = "Homunc Base:",
                Location = new Point(240, 10),
                Size = new Size(80, 20),
                TextAlign = ContentAlignment.MiddleLeft
            };

            homunculusBaseFilter = new ComboBox
            {
                Location = new Point(325, 10),
                Size = new Size(80, 20),
                DropDownStyle = ComboBoxStyle.DropDownList
            };
            homunculusBaseFilter.Items.AddRange(new string[] { "All Types", "Lif", "Amistr", "Filir", "Vanilmirth" });
            homunculusBaseFilter.SelectedIndex = 0;

            // Create tab control
            tabControl = new TabControl
            {
                Location = new Point(10, 40),
                Size = new Size(this.Width - 20, this.Height - 150),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right | AnchorStyles.Bottom
            };

            // Create tabs for each category
            string[] categories = {
                "Basic Options",
                "AutoSkill Options", 
                "Walk/Follow Options",
                "Autobuff Options",
                "Berserk Options",
                "Friending Options",
                "PVP Options",
                "Standby Options",
                "Kiting Options"
            };

            foreach (string category in categories)
            {
                TabPage tabPage = new TabPage(category);
                PropertyGrid propertyGrid = new PropertyGrid
                {
                    Dock = DockStyle.Fill,
                    PropertySort = PropertySort.Alphabetical,
                    ToolbarVisible = false,
                    HelpVisible = false
                };
                
                tabPage.Controls.Add(propertyGrid);
                tabControl.TabPages.Add(tabPage);
            }

            // Create help text area
            helpLabel = new Label
            {
                Text = "Description:",
                Location = new Point(10, this.Height - 100),
                Size = new Size(80, 20),
                Anchor = AnchorStyles.Bottom | AnchorStyles.Left,
                TextAlign = ContentAlignment.MiddleLeft
            };

            helpTextBox = new TextBox
            {
                Location = new Point(10, this.Height - 80),
                Size = new Size(this.Width - 20, 70),
                Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right,
                Multiline = true,
                ReadOnly = true,
                ScrollBars = ScrollBars.Vertical,
                Text = "Select a property to see its description here."
            };

            // Add controls to the user control
            this.Controls.Add(searchLabel);
            this.Controls.Add(searchBox);
            this.Controls.Add(homunculusBaseLabel);
            this.Controls.Add(homunculusBaseFilter);
            this.Controls.Add(tabControl);
            this.Controls.Add(helpLabel);
            this.Controls.Add(helpTextBox);

            // Resume layout and add event handlers after initialization
            this.ResumeLayout();

            // Add event handlers after controls are created
            searchBox.TextChanged += SearchBox_TextChanged;
            homunculusBaseFilter.SelectedIndexChanged += Filter_Changed;

            // Add PropertyGrid event handlers
            foreach (TabPage tabPage in tabControl.TabPages)
            {
                PropertyGrid propertyGrid = tabPage.Controls[0] as PropertyGrid;
                if (propertyGrid != null)
                {
                    propertyGrid.PropertyValueChanged += PropertyGrid_PropertyValueChanged;
                    propertyGrid.SelectedGridItemChanged += PropertyGrid_SelectedGridItemChanged;
                }
            }

        }

        private void SearchBox_TextChanged(object sender, EventArgs e)
        {
            ApplyFilters();
        }

        private void Filter_Changed(object sender, EventArgs e)
        {
            ApplyFilters();
        }

        private void PropertyGrid_PropertyValueChanged(object s, PropertyValueChangedEventArgs e)
        {
            if (PropertyValueChanged != null)
                PropertyValueChanged(s, e);
        }

        private void PropertyGrid_SelectedGridItemChanged(object sender, SelectedGridItemChangedEventArgs e)
        {
            if (e.NewSelection != null && e.NewSelection.PropertyDescriptor != null)
            {
                var descriptor = e.NewSelection.PropertyDescriptor;
                var descriptionAttribute = descriptor.Attributes[typeof(DescriptionAttribute)] as DescriptionAttribute;
                
                if (descriptionAttribute != null && !string.IsNullOrEmpty(descriptionAttribute.Description))
                {
                    helpTextBox.Text = descriptionAttribute.Description;
                }
                else
                {
                    helpTextBox.Text = "No description available for this property.";
                }
            }
            else
            {
                helpTextBox.Text = "Select a property to see its description here.";
            }
        }

        private void RefreshAllTabs()
        {
            if (_hconf == null) return;

            categoryWrappers.Clear();
            foreach (TabPage tabPage in tabControl.TabPages)
            {
                PropertyGrid propertyGrid = tabPage.Controls[0] as PropertyGrid;
                if (propertyGrid != null)
                {
                    ApplyFilterToPropertyGrid(propertyGrid, tabPage.Text);
                }
            }
        }

        private void ApplyFilters()
        {
            if (_hconf == null) return;

            foreach (TabPage tabPage in tabControl.TabPages)
            {
                PropertyGrid propertyGrid = tabPage.Controls[0] as PropertyGrid;
                if (propertyGrid != null)
                {
                    ApplyFilterToPropertyGrid(propertyGrid, tabPage.Text);
                }
            }
        }

        private void ApplyFilterToPropertyGrid(PropertyGrid propertyGrid, string category)
        {
            string searchText = searchBox != null && searchBox.Text != null ? searchBox.Text.ToLower() : "";
            string homunculusBaseType = homunculusBaseFilter != null && homunculusBaseFilter.SelectedItem != null ? homunculusBaseFilter.SelectedItem.ToString() : "All";

            // Create or get the filtered wrapper object
            string key = category;
            if (!categoryWrappers.ContainsKey(key))
            {
                categoryWrappers[key] = new FilteredHomConfWrapper(_hconf, category);
            }

            var wrapper = categoryWrappers[key];
            wrapper.UpdateFilters(searchText, "All Types", homunculusBaseType);
            propertyGrid.SelectedObject = wrapper;
        }

        public new void Refresh()
        {
            RefreshAllTabs();
        }

        public void UpdateData()
        {
            RefreshAllTabs();
        }

        private void UpdateFilterToType(ComboBox filterComboBox, string targetType)
        {
            if (filterComboBox == null) return;

            for (int i = 0; i < filterComboBox.Items.Count; i++)
            {
                if (filterComboBox.Items[i].ToString() == targetType)
                {
                    filterComboBox.SelectedIndex = i;
                    ApplyFilters();
                    break;
                }
            }
        }

        private void SetupFileMonitoring()
        {
            try
            {
                // Ensure the data directory exists
                string dataDir = Path.GetDirectoryName(htypeFilePath);
                if (!Directory.Exists(dataDir))
                {
                    Directory.CreateDirectory(dataDir);
                }

                // Setup file system watcher
                fileWatcher = new FileSystemWatcher();
                fileWatcher.Path = dataDir;
                fileWatcher.Filter = "detected_htype.txt";
                fileWatcher.NotifyFilter = NotifyFilters.LastWrite | NotifyFilters.CreationTime;
                fileWatcher.Changed += OnHTypeFileChanged;
                fileWatcher.Created += OnHTypeFileChanged;
                fileWatcher.EnableRaisingEvents = true;

                // Setup timer for periodic checks (fallback)
                fileCheckTimer = new Timer();
                fileCheckTimer.Interval = 5000; // Check every 5 seconds
                fileCheckTimer.Tick += OnFileCheckTimer;
                fileCheckTimer.Start();

                // Initial check
                CheckHTypeFile();
            }
            catch
            {
                // Silently handle setup errors
            }
        }

        private void OnHTypeFileChanged(object sender, FileSystemEventArgs e)
        {
            // Use BeginInvoke to handle file changes on UI thread
            if (this.IsHandleCreated)
            {
                this.BeginInvoke(new Action(() => CheckHTypeFile()));
            }
        }

        private void OnFileCheckTimer(object sender, EventArgs e)
        {
            CheckHTypeFile();
        }

        private void CheckHTypeFile()
        {
            try
            {
                if (File.Exists(htypeFilePath))
                {
                    string[] lines = File.ReadAllLines(htypeFilePath);
                    string detectedHomunculusBase = "";

                    foreach (string line in lines)
                    {
                        if (line.StartsWith("HomunculusBase="))
                        {
                            detectedHomunculusBase = line.Substring("HomunculusBase=".Length);
                        }
                    }

                    // Update filters if types changed
                    bool filtersChanged = false;

                    if (!string.IsNullOrEmpty(detectedHomunculusBase) && detectedHomunculusBase != lastHomunculusBase)
                    {
                        lastHomunculusBase = detectedHomunculusBase;
                        UpdateFilterToType(homunculusBaseFilter, detectedHomunculusBase);
                        filtersChanged = true;
                    }
                }
            }
            catch
            {
                // Silently handle file read errors
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (fileWatcher != null)
                {
                    fileWatcher.Dispose();
                    fileWatcher = null;
                }
                if (fileCheckTimer != null)
                {
                    fileCheckTimer.Dispose();
                    fileCheckTimer = null;
                }
            }
            base.Dispose(disposing);
        }
    }

    // Custom wrapper class that implements filtering using TypeDescriptor
    [TypeDescriptionProvider(typeof(FilteredHomConfTypeDescriptionProvider))]
    internal class FilteredHomConfWrapper : ICustomTypeDescriptor
    {
        private HomConf _originalConf;
        private string _category;
        private string _searchText = "";
        private string _homunculusSType = "All";
        private string _homunculusBaseType = "All";
        private PropertyDescriptorCollection _filteredProperties;

        // Cache skill arrays for better performance
        private static readonly Dictionary<string, string[]> SkillCache = new Dictionary<string, string[]>
        {
            { "sera", new[] { "paralyze", "poisonmist", "painkiller", "calllegion" } },
            { "eira", new[] { "silentbreeze", "xenoslasher", "erasercutter", "overedboost", "regene" } },
            { "eleanor", new[] { "sonicclaw", "silvervein", "midnight", "tinderbreaker", "switchmode" } },
            { "bayeri", new[] { "stahlhorn", "hailege", "goldene", "steinwand", "angriffs" } },
            { "dieter", new[] { "lavaslide", "magmaflow", "granitic", "pyroclastic", "volcanic" } },
            { "lif", new[] { "escape", "breeze" } },
            { "amistr", new[] { "bulwark", "castle", "bloodlust" } },
            { "filir", new[] { "flit", "accel", "moon", "speed" } },
            { "vanilmirth", new[] { "caprice", "chaotic", "selfdestruct" } }
        };

        public FilteredHomConfWrapper(HomConf originalConf, string category)
        {
            _originalConf = originalConf;
            _category = category;
            UpdateFilteredProperties();
        }

        public void UpdateFilters(string searchText, string homunculusSType, string homunculusBaseType)
        {
            _searchText = searchText;
            _homunculusSType = homunculusSType;
            _homunculusBaseType = homunculusBaseType;
            UpdateFilteredProperties();
        }

        private void UpdateFilteredProperties()
        {
            if (_originalConf == null)
            {
                _filteredProperties = new PropertyDescriptorCollection(null);
                return;
            }

            List<PropertyDescriptor> filteredProps = new List<PropertyDescriptor>();
            PropertyDescriptorCollection originalProps = TypeDescriptor.GetProperties(_originalConf);

            foreach (PropertyDescriptor prop in originalProps)
            {
                // Check category
                if (prop.Category != _category)
                    continue;

                // Apply search filter
                if (!string.IsNullOrEmpty(_searchText))
                {
                    string propName = prop.Name.ToLower();
                    string displayName = prop.DisplayName.ToLower();
                    
                    if (!propName.Contains(_searchText) && !displayName.Contains(_searchText))
                        continue;
                }

                // Apply Homunculus type filters
                if (!ShouldShowProperty(prop.Name, _homunculusSType, _homunculusBaseType))
                    continue;

                // Create a wrapper descriptor that redirects to the original object
                filteredProps.Add(new WrappedPropertyDescriptor(prop, _originalConf));
            }

            _filteredProperties = new PropertyDescriptorCollection(filteredProps.ToArray());
        }

        private string GetTypeName(string filterValue)
        {
            return filterValue;
        }

        private bool ShouldShowProperty(string propertyName, string homunculusSType, string homunculusBaseType)
        {
            string propNameLower = propertyName.ToLower();

            // Check if this property belongs to a specific Homunculus type
            string belongsToHomunculusS = null;
            string belongsToHomunculusBase = null;

            // Check Homunculus S types using cached skills
            foreach (var kvp in SkillCache.Where(k => k.Key == "sera" || k.Key == "eira" || k.Key == "eleanor" || k.Key == "bayeri" || k.Key == "dieter"))
            {
                if (propNameLower.Contains(kvp.Key) || kvp.Value.Any(skill => propNameLower.Contains(skill)))
                {
                    belongsToHomunculusS = kvp.Key;
                    break;
                }
            }

            // Check Base Homunculus types using cached skills
            if (belongsToHomunculusS == null) // Avoid double-checking if already found
            {
                foreach (var kvp in SkillCache.Where(k => k.Key == "lif" || k.Key == "amistr" || k.Key == "filir" || k.Key == "vanilmirth"))
                {
                    if (propNameLower.Contains(kvp.Key) || kvp.Value.Any(skill => propNameLower.Contains(skill)))
                    {
                        belongsToHomunculusBase = kvp.Key;
                        break;
                    }
                }
            }

            // Apply Homunculus S filter
            if (homunculusSType != "All Types")
            {
                string selectedType = GetTypeName(homunculusSType).ToLower();
                
                // If property belongs to a specific Homunculus S and it's not the selected one, hide it
                if (belongsToHomunculusS != null && belongsToHomunculusS != selectedType)
                    return false;
            }

            // Apply Base Homunculus filter
            if (homunculusBaseType != "All Types")
            {
                string selectedType = GetTypeName(homunculusBaseType).ToLower();
                
                // If property belongs to a specific Base Homunculus and it's not the selected one, hide it
                if (belongsToHomunculusBase != null && belongsToHomunculusBase != selectedType)
                    return false;
            }

            return true;
        }

        #region ICustomTypeDescriptor Implementation
        public PropertyDescriptorCollection GetProperties()
        {
            return _filteredProperties;
        }

        public PropertyDescriptorCollection GetProperties(Attribute[] attributes)
        {
            return _filteredProperties;
        }

        public string GetComponentName() 
        { 
            return TypeDescriptor.GetComponentName(_originalConf, true); 
        }
        
        public TypeConverter GetConverter() 
        { 
            return TypeDescriptor.GetConverter(_originalConf, true); 
        }
        
        public EventDescriptor GetDefaultEvent() 
        { 
            return TypeDescriptor.GetDefaultEvent(_originalConf, true); 
        }
        
        public PropertyDescriptor GetDefaultProperty() 
        { 
            return TypeDescriptor.GetDefaultProperty(_originalConf, true); 
        }
        
        public object GetEditor(Type editorBaseType) 
        { 
            return TypeDescriptor.GetEditor(_originalConf, editorBaseType, true); 
        }
        
        public EventDescriptorCollection GetEvents() 
        { 
            return TypeDescriptor.GetEvents(_originalConf, true); 
        }
        
        public EventDescriptorCollection GetEvents(Attribute[] attributes) 
        { 
            return TypeDescriptor.GetEvents(_originalConf, attributes, true); 
        }
        
        public object GetPropertyOwner(PropertyDescriptor pd) 
        { 
            return _originalConf; 
        }
        
        public AttributeCollection GetAttributes() 
        { 
            return TypeDescriptor.GetAttributes(_originalConf, true); 
        }
        
        public string GetClassName() 
        { 
            return TypeDescriptor.GetClassName(_originalConf, true); 
        }
        #endregion
    }

    internal class WrappedPropertyDescriptor : PropertyDescriptor
    {
        private PropertyDescriptor _baseDescriptor;
        private object _targetObject;

        public WrappedPropertyDescriptor(PropertyDescriptor baseDescriptor, object targetObject)
            : base(baseDescriptor)
        {
            _baseDescriptor = baseDescriptor;
            _targetObject = targetObject;
        }

        public override bool CanResetValue(object component) 
        { 
            return _baseDescriptor.CanResetValue(_targetObject); 
        }
        
        public override Type ComponentType 
        { 
            get { return _baseDescriptor.ComponentType; } 
        }
        
        public override object GetValue(object component) 
        { 
            return _baseDescriptor.GetValue(_targetObject); 
        }
        
        public override bool IsReadOnly 
        { 
            get { return _baseDescriptor.IsReadOnly; } 
        }
        
        public override Type PropertyType 
        { 
            get { return _baseDescriptor.PropertyType; } 
        }
        
        public override void ResetValue(object component) 
        { 
            _baseDescriptor.ResetValue(_targetObject); 
        }
        
        public override void SetValue(object component, object value) 
        { 
            _baseDescriptor.SetValue(_targetObject, value); 
        }
        
        public override bool ShouldSerializeValue(object component) 
        { 
            return _baseDescriptor.ShouldSerializeValue(_targetObject); 
        }
    }

    internal class FilteredHomConfTypeDescriptionProvider : TypeDescriptionProvider
    {
        public override ICustomTypeDescriptor GetTypeDescriptor(Type objectType, object instance)
        {
            return instance as ICustomTypeDescriptor ?? base.GetTypeDescriptor(objectType, instance);
        }
    }
}
