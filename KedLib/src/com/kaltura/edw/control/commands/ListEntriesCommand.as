package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.edw.view.window.playlist.ManualPlaylistWindow;
	import com.kaltura.edw.vo.ListableVo;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaBaseEntryListResponse;
	import com.kaltura.vo.KalturaDocumentEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	import com.kaltura.vo.KalturaMixEntry;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import com.kaltura.edw.control.commands.KalturaCommand;

	public class ListEntriesCommand extends KalturaCommand implements ICommand,IResponder
	{
		private var _caller:ListableVo;
		
		/**
		 * @inheritDoc
		 */		
		override public function execute(event:CairngormEvent):void
		{
			 _model.increaseLoadCounter();
			 
			_caller = (event as SearchEvent).listableVo;
			var getMediaList:BaseEntryList = new BaseEntryList(_caller.filterVo as KalturaMediaEntryFilter ,_caller.pagingComponent.kalturaFilterPager );
		 	getMediaList.addEventListener(KalturaEvent.COMPLETE, result);
			getMediaList.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getMediaList);	  
		}

		/**
		 * @inheritDoc
		 */
		override public function result(data:Object):void
		{
			super.result(data);
			// the following variables are used to force  
			// their types to compile into the application
			var kme:KalturaMediaEntry; 
			var kbe:KalturaBaseEntry;
			var mix:KalturaMixEntry;
			var recivedData:KalturaBaseEntryListResponse = KalturaBaseEntryListResponse(data.data);
			if (!(_caller.parentCaller is ManualPlaylistWindow))
			{
				_model.selectedEntries = new Array();
			}
			// only use object we can handle
			var tempAr:Array = [];
			for each (var o:Object in recivedData.objects) {
				if (o is KalturaBaseEntry) {
					tempAr.push(o);
				}
			}
			_caller.arrayCollection = new ArrayCollection (tempAr);
			_model.entryDetailsModel.totalEntriesCount = recivedData.totalCount;
			_caller.pagingComponent.totalCount = recivedData.totalCount;
			_model.refreshEntriesRequired = false;
			_model.decreaseLoadCounter();
		}
		
	}
}