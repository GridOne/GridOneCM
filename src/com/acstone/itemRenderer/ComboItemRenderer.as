package com.acstone.itemRenderer
{
	import flash.events.MouseEvent;
	
	import mx.collections.IList;
	import mx.core.UIComponent;
	
	import spark.components.ComboBox;
	import spark.events.DropDownEvent;
	
	public class ComboItemRenderer extends UIComponent
	{
		
		public var combo:ComboBox;
		
		private var _dataList:IList;
		
		public function ComboItemRenderer()
		{
			super();
			
			if (!combo)
			{
				combo=new ComboBox();
				combo.addEventListener(DropDownEvent.OPEN,comboDropDownEventHandler);
				combo.addEventListener(MouseEvent.CLICK,comboMouseClickHandler);
				addChild(combo);
			}
		}
		
		public function get dataList():IList
		{
			return _dataList;
		}

		public function set dataList(value:IList):void
		{
			_dataList = value;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			this.setActualSize(unscaledWidth,unscaledHeight);
			this.combo.width=this.width-1;
			this.combo.height=this.height-1;
		 
		}
		
		override protected function commitProperties():void
		{
			this.combo.dataProvider=dataList;
		}
		
		public function comboDropDownEventHandler(event:DropDownEvent):void
		{
			this.combo.openDropDown();
		}
		
		public function comboMouseClickHandler(event:MouseEvent):void
		{
			this.combo.openDropDown();
		}
		
	}
}