// ===================================================================================================
//                           _  __     _ _
//                          | |/ /__ _| | |_ _  _ _ _ __ _
//                          | ' </ _` | |  _| || | '_/ _` |
//                          |_|\_\__,_|_|\__|\_,_|_| \__,_|
//
// This file is part of the Kaltura Collaborative Media Suite which allows users
// to do with audio, video, and animation what Wiki platfroms allow them to do with
// text.
//
// Copyright (C) 2006-2017  Kaltura Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// @ignore
// ===================================================================================================
package com.kaltura.vo
{
	import com.kaltura.vo.KalturaHttpNotificationData;

	[Bindable]
	public dynamic class KalturaHttpNotificationObjectData extends KalturaHttpNotificationData
	{
		/**
		* Kaltura API object type
		**/
		public var apiObjectType : String = null;

		/**
		* Data format
		* @see com.kaltura.types.KalturaResponseType
		**/
		public var format : int = int.MIN_VALUE;

		/**
		* Ignore null attributes during serialization
		* @see com.kaltura.types.kalturaBoolean
		**/
		public var ignoreNull : Boolean;

		/**
		* PHP code
		**/
		public var code : String = null;

		/**
		* An array of pattern-replacement pairs used for data string regex replacements
		**/
		public var dataStringReplacements : Array = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('apiObjectType');
			arr.push('format');
			arr.push('ignoreNull');
			arr.push('code');
			arr.push('dataStringReplacements');
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			return arr;
		}

		override public function getElementType(arrayName:String):String
		{
			var result:String = '';
			switch (arrayName) {
				case 'dataStringReplacements':
					result = 'KalturaKeyValue';
					break;
				default:
					result = super.getElementType(arrayName);
					break;
			}
			return result;
		}
	}
}
