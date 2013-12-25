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
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	
	public class Global
	{
 
		public static function initCallback(flex:GridOneCM):void
		{			
			if (ExternalInterface.available)
			{	
				ExternalInterface.addCallback("setDataProviderArray", flex.setDataProviderArray);
				ExternalInterface.addCallback("setHeaderArray", flex.setHeaderArray);
				ExternalInterface.addCallback("setColMerge", flex.setColMerge);
				ExternalInterface.addCallback("setRowMerge", flex.setRowMerge); 
				ExternalInterface.addCallback("creatGrid", flex.creatGrid);
				ExternalInterface.addCallback("setColWidthHeight", flex.setColWidthHeight);
			}			
		}
		
	}
}

