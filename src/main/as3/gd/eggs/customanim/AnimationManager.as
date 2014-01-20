package gd.eggs.customanim
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import gd.eggs.util.GlobalTimer;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class AnimationManager extends EventDispatcher
	{
		//=====================================================================
		//      CONSTANTS
		//=====================================================================

		//=====================================================================
		//      PARAMETERS
		//=====================================================================
		private static var _activeItems:Vector.<AnimationModel> = new Vector.<AnimationModel>();

		private static var _itemsById:Dictionary = new Dictionary();

		//=====================================================================
		//      CONSTRUCTOR, INIT
		//=====================================================================
		public function AnimationManager()
		{

		}

		//=====================================================================
		//      PUBLIC
		//=====================================================================
		//-----------------------------
		//      Single anim
		//-----------------------------
		public static function startAnimation(params:AnimationModel, id:Object):void
		{
			if (_itemsById[id])
			{
				_activeItems.splice(_activeItems.indexOf(params), 1);
				delete _itemsById[id];
			}

			params.mc.stop();
			_activeItems.push(params);
			_itemsById[id] = params;

			GlobalTimer.addFrameCallback(frameUpdate);
		}

		public static function stopAnimation(id:Object):void
		{
			var params:AnimationModel = _itemsById[id];
			if (!params) return;

			params.mc.stop();

			_activeItems.splice(_activeItems.indexOf(params), 1);
			delete _itemsById[id];

			if (!_activeItems.length) GlobalTimer.removeFrameCallback(frameUpdate);
		}

		//-----------------------------
		//      All
		//-----------------------------
		public static function pauseAll():void
		{
			GlobalTimer.removeFrameCallback(frameUpdate);
			for each(var param:AnimationModel in _activeItems)
			{
				param.mc.stop();
			}
		}

		public static function resumeAll():void
		{
			GlobalTimer.addFrameCallback(frameUpdate);
		}

		public static function clean():void
		{
			while(_activeItems.length) _activeItems.pop();
			for (var id:Object in _itemsById) delete _itemsById[id];
		}

		//=====================================================================
		//      PRIVATE
		//=====================================================================
		private static function frameUpdate(date:int):void
		{
			for each (var params:AnimationModel in _activeItems)
			{
				params.play(date);

				// если анимация доиграла до конца
				if (params.ended) stopAnimation(params);
			}
		}

		//=====================================================================
		//      HANDLERS
		//=====================================================================

		//=====================================================================
		//      ACCESSORS
		//=====================================================================
	}

}