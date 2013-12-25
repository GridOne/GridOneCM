﻿﻿﻿﻿	/**************************************************************************
		Flash player version require minimum 11.3.0
	**************************************************************************/
	var minimumVersion='11,3';
	/**************************************************************************
		*  Function to support get flash player version in javascript
	**************************************************************************/
	function getFlashVersion(){
	  try {
	    try {
	      var axo = new ActiveXObject('ShockwaveFlash.ShockwaveFlash.6');
	      try { axo.AllowScriptAccess = 'always'; }
	      catch(e) { return '6,0,0'; }
	    } catch(e) {}
	    return new ActiveXObject('ShockwaveFlash.ShockwaveFlash').GetVariable('$version').replace(/\D+/g, ',').match(/^,?(.+),?$/)[1];
	  } catch(e) {
	    try {
	      if(navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin){
	        return (navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]).description.replace(/\D+/g, ",").match(/^,?(.+),?$/)[1];
	      }
	    } catch(e) {}
	  }
	  return '0,0,0';
	}
	 
	var currentVersionArr= getFlashVersion().split(',');
	var minVersionArr=minimumVersion.split(',');
	
	if(currentVersionArr[0] < minVersionArr[0] || (currentVersionArr[0] == minVersionArr[0] && currentVersionArr[1] < minVersionArr[1] ))
	{
		//Please change to korean language in case you want to customize this message
	  	var answer = confirm ("Your current FlashPlayer is out of date. Do you want to update Flash Player?");
		if (answer)
			window.location="http://get.adobe.com/flashplayer/";
	}

	//달력아이프레임위치를 위해 마우스 이동시 좌표값(for KRX)
	var screenX;
	var screenY;
	//브라우저 종류 체크
	var browser = navigator.userAgent.toLowerCase();
	var grdObj = new Array();
	var debug=false;
	var container="";

	/**************************************************************************
    *  함  수  명 : initGridOne
    *  입력 필드
    *        objName     : GridOne Object명
    *        width       : GridOne Width
    *        height      : GridOne Height
    *        bridgeName  : FA Bridge 명
    *        xmlConfig   : GridOne config.xml 파일의 경로
    *        serialKey   : GridOne release or developer version
    *        debugMode   : GridOne debuge (false)(optional)
    *        performanceMode : fast or normal (optional)
    *        containerid : use for multiple GridOne. (optional)
    *  리  턴  값 : 없음
    *  설      명 : 그리드 Object를 생성한다.
    **************************************************************************/

	function initGridOne(width,height,objName,bridgeName,xmlConfig,serialKey,debugMode,performanceMode,containerid)
	{
		 
		gridOne_path="";
		debug=debugMode;
		grdObj.push(objName);
		if (!containerid)
			container="";
		else
			container=containerid ;
		
		var gridTag="<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' id='"+objName+"' width="+width+" height="+height;
		gridTag+=" codebase='http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab'>";
		gridTag+="<param name='movie' value='"+gridOne_path+"GridOneCM.swf'/>";
		gridTag+="<param name='quality' value='high' />";
		gridTag+="<param name='autocomplete' value='on' />";
		gridTag+="<param name='hasPriority' value='true' />";
		gridTag+="<param name='bgcolor' value='#e0e0e0'/>";
		gridTag+="<param name='allowScriptAccess' value='samedomain' />";
		gridTag+="<param name='wmode' value='transparent' />";
		gridTag+="<param name='flashVars' value='initialize="+container+"initializeHandler&bridgeName="+bridgeName+"&configURL="+xmlConfig+"&serialKey="+serialKey+"&bDebugMode="+debugMode+"'/>";
		gridTag+="<embed src='"+gridOne_path+"GridOneCM.swf' quality='high' bgcolor='#e0e0e0' width="+width+" height="+height+" name='"+objName+"' id='"+objName+"1' align='middle' play='true' loop='false'";
		gridTag+=" quality='high' allowScriptAccess='samedomain' wmode='transparent' type='application/x-shockwave-flash' pluginspage='http://www.adobe.com/go/getflashplayer'";
		gridTag+=" flashVars='initialize="+container+"initializeHandler&performanceMode=" + performanceMode +"&bridgeName="+bridgeName+"&configURL="+xmlConfig+"&serialKey="+serialKey+"&bDebugMode="+debugMode+"'> </embed> </object>";
		document.write(gridTag);
	} 
 
	
 
