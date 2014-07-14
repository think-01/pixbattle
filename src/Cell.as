/**
 * Created with IntelliJ IDEA.
 * User: wizzard
 * Date: 14.07.14
 * Time: 11:09
 * To change this template use File | Settings | File Templates.
 */
package {
public class Cell {
    public var index : uint;
    public var solider : Solider;
    public var siblings : Vector.<Cell> = new Vector.<Cell>();
    public var x,y : uint;
    public var isObstacle : Boolean;

    public function Cell( obstacle : Boolean = false )
    {
        isObstacle = false;
    }

    public function get pixel() : uint
    {
        return 0xFF000000 | ( solider != null ? solider.army.color : 0xFFFFFF );
    }
}
}
