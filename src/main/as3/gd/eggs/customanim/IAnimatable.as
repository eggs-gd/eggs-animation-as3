/**
 * Created by Dukobpa3 on 1/14/14.
 */
package gd.eggs.customanim
{
	public interface IAnimatable
	{
		function get visible():Boolean;
		function set visible(visible:Boolean):void;

		function get currentFrame():int;
		function get totalFrames():int;

		function gotoAndStop(frame:Object, scene:String = null):void;
		function nextFrame():void;
		function stop():void;
	}
}
