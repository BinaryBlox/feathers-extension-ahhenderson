package feathers.extension.ahhenderson.helpers
{
	import starling.display.Image;
	import starling.textures.Texture;

	public class AssetHelper
	{
		public function AssetHelper()
		{
		}
		
		include "_Helpers.inc";
		 

		public static function getImage(textureName:String):Image{
			return new Image(fmgr.theme.assetManager.getTexture(textureName)); 
		}
		
		public static function getTexture(textureName:String):Texture{
			
			return  fmgr.theme.assetManager.getTexture(textureName);
		}
	}
}