////////////////////////////////////////////////////////////////////////////////
//
//  ACTSONE COMPANY
//  Copyright 2013 Actsone 
//  All Rights Reserved.
//
//	This program is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////
package com.actsone
{
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.container.ScrollPolicy;
	
	import mx.containers.Box;
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	import spark.components.Button;
 
	public class MGridHeader extends UIComponent
	{
		
		private var _headerInfor:Array=[];
		
		private var boxHeader:Box;
		
		private var cvGridHeader:Canvas;
 
		//header height
		public  var headerHeight:Number=25;
		
		//header width
		public var headerWidth:Number;
		
		//gridWidth
		public var gridWidth:Number=0;
		
		//column number
		public var cols:Number=0;
 
		/**************************************************************
		 * Constructor
		 * */
		public function MGridHeader(w:Number,hW:Number,hH:Number)
		{
			super();
 
			this.gridWidth=w;
			this.headerWidth=hW;
			this.headerHeight=hH;
			
			if (!cvGridHeader)
			{
				cvGridHeader=new Canvas();
				cvGridHeader.width=this.gridWidth;
				cvGridHeader.height=this.headerHeight;
				cvGridHeader.verticalScrollPolicy=ScrollPolicy.OFF;
			 	cvGridHeader.horizontalScrollPolicy=ScrollPolicy.OFF;
			
				this.addChild(cvGridHeader);
			}
			
		}
		
		/**************************************************************
		 * set header information
		 * */
		public function get headerInfor():Array
		{
			return _headerInfor;
		}

		/**
		 * @private
		 */
		public function set headerInfor(value:Array):void
		{
			_headerInfor = value;
		}

		/**************************************************************
		 * Start draw header
		 * */
		public function drawHeader():void
		{
			var xCoord:Number=0;
			var yCoord:Number=0;
			var cellWidth:Number;
			var cellHeight:Number;
			cols=this.headerInfor.length;
	 
			for (var i:int=0;i<cols;i++)
			{
				boxHeader=new Box();
				
				boxHeader.addEventListener(MouseEvent.ROLL_OVER, boxHeaderMouseRollOverHandler);
				boxHeader.addEventListener(MouseEvent.ROLL_OUT,boxHeaderMouseRollOutHandler);
			 
				xCoord = (i * (this.headerWidth + 0)) + 0;;
				yCoord = (0 * (0 + this.headerHeight)) + 0;
				
				cellWidth=this.headerWidth;
				cellHeight=this.headerHeight;
			 
				this.cvGridHeader.addChild(boxHeader); 
				
				boxHeader.x=xCoord;
				boxHeader.y=yCoord; 
		 
				boxHeader.graphics.beginFill(0xDCDCDC);
			 	boxHeader.graphics.lineStyle(1,0xD3D3D3);
				boxHeader.graphics.drawRect(0,0,cellWidth,cellHeight);
				
				boxHeader.blendMode=BlendMode.MULTIPLY;
				boxHeader.width=cellWidth;
				boxHeader.height=cellHeight;
			  	boxHeader.graphics.endFill();
				
				var label:Label=new Label();
				label.text=this.headerInfor[i];
				label.width=100;
				label.height=this.headerHeight;
 
				this.boxHeader.addChild(label);
				
			}
			 
		}
		
		/**************************************************************
		 * Header mouse roll over handler
		 * */
		public function boxHeaderMouseRollOverHandler(event:MouseEvent):void
		{
			 var obj:Box=event.currentTarget as Box;
		     obj.setFocus();
			 obj.setStyle("backgroundColor",0x4682B4);
			 obj.blendMode=BlendMode.HARDLIGHT;
			 
			// Alert.show("mouse click");
		}
		
		/**************************************************************
		 * Header mouse roll out handler
		 * */
		public function boxHeaderMouseRollOutHandler(event:MouseEvent):void
		{
			var obj:Box=event.currentTarget as Box;
			//obj.setFocus();
		 	obj.setStyle("backgroundColor",0xDCDCDC);
			obj.blendMode=BlendMode.MULTIPLY;
		}
		
		/**************************************************************
		 * Update list
		 * */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void    
		{
			cvGridHeader.setStyle("textAlign","center");
 
	        drawHeader();
		}
		
		/**************************************************************
		 * Scroll handler
		 * */
		public function startScroll(pos:Number):void
		{
			cvGridHeader.horizontalScrollPosition =pos;
			cvGridHeader.verticalScrollPosition=0;
			this.validateNow();
		}
	}
}