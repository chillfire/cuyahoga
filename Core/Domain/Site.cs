using System;
using System.Collections;

namespace Cuyahoga.Core.Domain
{
	/// <summary>
	/// Summary description for Site.
	/// </summary>
	public class Site
	{
		private int _id;
		private string _name;
		private string _siteUrl;
		private string _defaultCulture;
		private Template _defaultTemplate;
		private IList _rootNodes;
		private DateTime _updateTimestamp;

		#region properties

		/// <summary>
		/// Property Id (int)
		/// </summary>
		public int Id
		{
			get { return this._id; }
			set { this._id = value; }
		}

		/// <summary>
		/// Property Name (string)
		/// </summary>
		public string Name
		{
			get { return this._name; }
			set { this._name = value; }
		}

		/// <summary>
		/// Property HomeUrl (string)
		/// </summary>
		public string SiteUrl
		{
			get { return this._siteUrl; }
			set { this._siteUrl = value; }
		}

		/// <summary>
		/// Property DefaultCulture (string)
		/// </summary>
		public string DefaultCulture
		{
			get { return this._defaultCulture; }
			set { this._defaultCulture = value; }
		}

		/// <summary>
		/// Property DefaultTemplate (Template)
		/// </summary>
		public Template DefaultTemplate
		{
			get { return this._defaultTemplate; }
			set { this._defaultTemplate = value; }
		}

		/// <summary>
		/// Property RootNodes (IList)
		/// </summary>
		public IList RootNodes
		{
			get { return this._rootNodes; }
			set { this._rootNodes = value; }
		}

		/// <summary>
		/// Property UpdateTimestamp (DateTime)
		/// </summary>
		public DateTime UpdateTimestamp
		{
			get { return this._updateTimestamp; }
			set { this._updateTimestamp = value; }
		}

		#endregion

		public Site()
		{
			this._id = -1;
		}
	}
}