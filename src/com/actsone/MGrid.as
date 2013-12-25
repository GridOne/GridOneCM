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
	import com.acstone.itemRenderer.ComboItemRenderer;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import flashx.textLayout.container.ScrollPolicy;
	
	import mx.containers.Box;
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDirection;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	

	public class MGrid extends UIComponent
	{
		/**************************************************************
		 * Constructor
		 * */
		public function MGrid()
		{
			super();
 
		}
		
		/**************************************************************
		 * Common property
		 * */
		public var cvGridHeader:MGridHeader;
		
		public var rowPad:Number =0; // Holds value of row padding.
		
		public var colPad:Number =0; // Holds value of column padding.
 
		public var gridHeight:Number; // grid must have dimension to fit 
		
		public var gridWidth:Number;   // cells
		
		public var cell:Box;
		
		public var cvGrid:Canvas;
		
		public var headerBox:Box;
		
		public var bodyBox:Box;
		
		public var  item:*;
		 
		private var _dataProvider:Array=[];
		
		public var bk_dataProvider:Array=[];
		
		public var initDataDraw:Array=[];
		
		public var eachCell:Array=[];
		
		public var nhorizotalScrollPosition:Number;
		
		public var cellBackgroundColor:uint=0xFFFFFF;
		
		public  var cellWidth:Number=100;
		
		public var  cellHeight:Number=25;
		
		//Header infor
		//////////////////////////////////////
		 
		private var _headerInfor:Array=[];
		
		public var headerHeight:Number=25;
 
		//Set property for column merge
		//////////////////////////////////////
		public var colMRowIndex:Number;
		
		public var startColIndex:Number=-1;
		
		public var numMergeCol:Number;
		
		public var endColIndMerge:Number;
		
		public var colMergeInfor:Array=[];
		
		public var bColMerge:Boolean=false;
		
		public var colMBgColor:uint;
		
		//set property for row merge
		////////////////////////////////////////
		
		public var startRowIndMerge:Number=-1;
		
		public var endRowIndMerge:Number;
		
		public var inColInd:Number;
		
		public var numMergeRow:Number;
		
		public var rowMergeInfo:Array=[];
		
		public var bRowMerge:Boolean=false;
		
		public var rowMBgColor:uint;
		
		/////////////////////////////////////
		//  Add ItemRenderer
		////////////////////////////////////
		public var combo:Object;
		public var dataCombo:Array;
		public var comboInfor:Array;
		
		
		public function get headerInfor():Array
		{
			return _headerInfor;
		}

		public function set headerInfor(value:Array):void
		{
			_headerInfor = value;
		}

		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
			bk_dataProvider=value;
		}
		
		public function invilidateList():void
		{
			this.invalidateDisplayList();
		}
 
        /**************************************************************
		 * set columns merge 
		 * */
		public function setColMerge(rowInd:Number,startColIndMerge:Number,endColIndMerge:Number, bgColor:uint):void
		{
			var arr:Array=new Array();
			this.colMRowIndex=rowInd;
			this.startColIndex=startColIndMerge;
			this.endColIndMerge=endColIndMerge;
			this.numMergeCol= endColIndMerge-startColIndMerge + 1;
		    this.colMBgColor=bgColor;
			
			arr=[this.colMRowIndex,this.startColIndex,this.endColIndMerge,this.numMergeCol,this.colMBgColor];
			this.colMergeInfor.push(arr);
		}
		
		/**************************************************************
		 * set rows merge 
		 * */
		public function setRowMerge(startRowIndMerge:Number,endColIndMerge:Number,inColInd:Number,bgColor:uint):void
		{
			var arr:Array=new Array();
			this.startRowIndMerge=startRowIndMerge;
			this.inColInd=inColInd;
			this.endRowIndMerge=endColIndMerge;
			this.numMergeRow=endColIndMerge - startRowIndMerge +1;
			this.rowMBgColor=bgColor;
			
			 arr[0]=this.startRowIndMerge;
			 arr[1]=this.inColInd;
			 arr[2]=this.endRowIndMerge;
			 arr[3]=this.numMergeRow;
			 arr[4]=this.rowMBgColor;
			 
			 this.rowMergeInfo.push(arr);
		}
		
		/**************************************************************
		 * defineGrid for initial laoding 
		 * */
		public function defineGrid():void
		{
			 
			if (!cvGridHeader)
			{
				cvGridHeader=new MGridHeader(gridWidth,this.cellWidth,this.headerHeight);
				cvGridHeader.headerInfor=this.headerInfor;
				cvGridHeader.graphics.lineStyle(2,0xC0C0C0);
				cvGridHeader.graphics.drawRect(0,0,this.gridWidth + 18,this.headerHeight);
				cvGridHeader.graphics.endFill();
				 
			 //	cvGridHeader.blendMode=BlendMode.MULTIPLY;
				
				cvGridHeader.x=0;
				cvGridHeader.y=0;
				this.addChild(cvGridHeader);
				
		    }
			if (!cvGrid)
			{
				cvGrid=new Canvas();
			//	cvGrid.blendMode=BlendMode.MULTIPLY;
				cvGrid.graphics.lineStyle(2,0xC0C0C0);
				cvGrid.graphics.drawRect(0,0,gridWidth +18 ,this.gridHeight);
				cvGrid.graphics.endFill();
				cvGrid.width=gridWidth + 18 ;
				cvGrid.height=this.gridHeight;
	 
				cvGrid.addEventListener(ScrollEvent.SCROLL,scrollEventHandler);
				cvGrid.x=0;
				cvGrid.y=this.headerHeight;
			}
			
		//	cutArrayData(); 
			
			spriteGrid();
			
		}//funct defineGrid
 
 
		/**************************************************************
		 * Scroll event handler
		 * */
		public function scrollEventHandler(event:ScrollEvent):void
		{
			if (event.direction==ScrollEventDirection.HORIZONTAL)
			{
				cvGridHeader.startScroll(event.position); 
				nhorizotalScrollPosition=event.position;
			}
			else
			{
				
			}
 
		}
		
		/**************************************************************
		 * Update list
		 * */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void    
		{
			//   this.setActualSize(unscaledWidth,unscaledHeight);
			this.width = unscaledWidth;
			this.height = unscaledHeight;
			
			spriteGrid();
		//	Alert.show(this.width +"" + "he" + this.height);
		}
		
		/**************************************************************
		 * cut array for init loading
		 * */
		public function cutArrayData():void
		{
			if (this.dataProvider.length > 20)
			{
				for (var i:int=0;i<20;i++)
				{
					initDataDraw.push(this.dataProvider[i]);
				}
			}
			else
			{
				initDataDraw=this.dataProvider;
			}
			 
		}
		
		/**************************************************************
		 *  Draw grid 
		 * */
		private function spriteGrid():void  
		{
			
			var rows:Number = this.dataProvider.length;
			var cols:Number =  this.headerInfor.length;
			
	    	//  var cellWidth:Number = ( gridWidth - ( ( cols + 1 ) * colPad ) )  / cols;
			 
			// Set cell height.
			
		 //	 var cellHeight:Number = ( gridHeight - ( ( rows + 1 ) * rowPad ) ) / rows;
		 
			//x coordinate.
			
			var xCoord:Number = 0;
			
			//y coordinate.
			
			var yCoord:Number = 0;
	 
			var  bdraw:Boolean=false;
			
			var skipRowD:Boolean=false;
			var skipColD:Boolean=false;
 
			//Loop to create columns.
			for ( var col:Number = 0; col < cols; col++)
			{
				// increment xCoord with each iteration
  
				xCoord = (col * (cellWidth + colPad)) + colPad;;
				
				// Loop to create rows
				
				for ( var row:Number = 0; row < rows; row++ )
				{
					
					// increment yCoord
					
					yCoord = (row * (rowPad + cellHeight)) + rowPad;
					
					// Instantiate cells
					
					cell = new Box();
					
					cell.addEventListener(MouseEvent.ROLL_OVER,cellMouseRollOverHandler);
					cell.addEventListener(MouseEvent.ROLL_OUT,cellMouseRollOutHandler);
					
					cell.id="ITEM_" + row + "_" + col ;
					this.cvGrid.addChild(cell);
				    this.addChild(cvGrid);
 
					item=new Label();
					 
					// set coordinates of cell
					
					cell.x = xCoord;
					
					cell.y = yCoord;
 
						var  calCellWidth:Number;
						var  calCellHeight:Number;
						var  lbX:Number;
						var  lbY:Number;
						
						var  rowIdex:Number=row;
 
   						 for (var i:int=0;i<this.rowMergeInfo.length;i++)
					     {
							 if (col==this.rowMergeInfo[i][1] && rowIdex==this.rowMergeInfo[i][0])
							 {
								 this.bRowMerge=true;
								 calCellHeight=cellHeight*this.rowMergeInfo[i][3];
								 item.height=25;
							//	 var btn:Button=new Button();
								// btn.height=25;
								 
								 cell.graphics.beginFill(this.rowMergeInfo[i][4]);
								 cell.graphics.lineStyle(1, 0xD3D3D3);
								 cell.graphics.drawRect(0,0,cellWidth,calCellHeight);
								 cell.width=cellWidth;
								 cell.height=calCellHeight;
								 cell.blendMode=BlendMode.MULTIPLY;
								 
//								 btn.x=xCoord;
//								 btn.y=yCoord;
//								 btn.label=this.dataProvider[row][col];
//								 cell.addChild(btn);
								 item.x=xCoord;
								 item.y=yCoord;
								 item.text=this.dataProvider[row][col];
								 cell.addChild(item);
								 break;
								 
							 }
							 else if (row >this.rowMergeInfo[i][0]  && row <=this.rowMergeInfo[i][2] && col==this.rowMergeInfo[i][1])
							 {
								 skipRowD=true;
								 break;
							 }
							 else
							 {
									 bdraw=true;
									 skipRowD=false; 
									 this.bRowMerge=false;
							  }
						   }
						
						   for (var k:int=0;k<this.colMergeInfor.length;k++)
						   {
								 if (col==this.colMergeInfor[k][1] && rowIdex==this.colMergeInfor[k][0])
								 {
									 this.bColMerge=true;
									 calCellWidth=cellWidth*this.colMergeInfor[k][3];
									 
									 cell.graphics.beginFill(this.colMergeInfor[k][4]);
									 cell.graphics.lineStyle(1, 0xD3D3D3);
									 cell.graphics.drawRect(0,0,calCellWidth,cellHeight);
									 cell.width=calCellWidth;
									 cell.height=cellHeight;
									 cell.blendMode=BlendMode.MULTIPLY;
									 
									 item.text=this.dataProvider[row][col];
									 item.x=xCoord;
									 item.y=yCoord;
									 cell.addChild(item);
									 break;
								   
								 }
								 else if (col >this.colMergeInfor[k][1] && col <=this.colMergeInfor[k][2] && rowIdex==this.colMergeInfor[k][0])
								 {
									 skipColD=true;
									 break;
								 }
								 else{
									 
										 bdraw=true;
										 skipColD=false;
										 this.bColMerge=false;
								 }
								  
							 }
						   
						   if ((this.bRowMerge ==false && skipRowD==false && this.bColMerge ==false && skipColD==false))
						   {
							   cell.graphics.beginFill(this.cellBackgroundColor);
							   cell.graphics.lineStyle(1, 0xD3D3D3);
							   cell.graphics.drawRect(0,0, cellWidth, cellHeight);
							   cell.width=cellWidth;
							   cell.height=cellHeight;
							   cell.blendMode=BlendMode.MULTIPLY;
							   
							   if (col==4 && row==0)
							   {
								  item=new ComboItemRenderer();
								  item.x=xCoord;
								  item.y=yCoord;
								  cell.addChild(item); 
								  this.eachCell.push(cell);
								  bdraw=false;
							   }
							   else
							   {
								   item.text=this.dataProvider[row][col];
								   item.x=xCoord;
								   item.y=yCoord;
								   cell.addChild(item); 
								   this.eachCell.push(cell);
								   bdraw=false; 
							   }
							  
						   }
			   }
  
			}//for
			
		}//funct spriteGrid
		
		
		/**************************************************************
		 * Item mouse over handler
		 * */
		public function cellMouseRollOverHandler(event:MouseEvent):void
		{
			var obj:Box=event.currentTarget as Box;
			obj.setFocus();
			obj.setStyle("backgroundColor",0x4682B4);
		 	obj.blendMode=BlendMode.HARDLIGHT;
			 
		}
		
		/**************************************************************
		 * Item mouse out handler
		 * */
		public function cellMouseRollOutHandler(event:MouseEvent):void
		{
			var obj:Box=event.currentTarget as Box;
			if (obj.width > this.cellWidth || obj.height > this.cellHeight)
			{
				obj.setStyle("backgroundColor",this.colMBgColor);
				obj.blendMode=BlendMode.MULTIPLY;
			}
			else
			{
				obj.setStyle("backgroundColor",this.cellBackgroundColor);
				obj.blendMode=BlendMode.MULTIPLY;
			}
		}
		
	 }//class Grid
}
 