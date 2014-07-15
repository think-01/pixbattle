/**
 * Created with IntelliJ IDEA.
 * User: wizzard
 * Date: 14.07.14
 * Time: 10:03
 * To change this template use File | Settings | File Templates.
 */
package {

public class Solider{
    private var stamina :       uint;
    public var army : Army;
    public var cell : Cell;

    public function Solider( a : Army ) {
        army = a;
        stamina = 50;
    }

    public function Move() : uint
    {
        var candidates : Array = [];
        for( var i : uint = 0; i <cell.siblings.length; i++ )
        {
            candidates.push(
                    {
                        c: cell.siblings[i],
                        d:  D( cell.siblings[i] )
                    }
            )
        }

        candidates.sort( SortCandidates );
        for( var i: uint = 0; i<candidates.length; i++ )
        {
            var candidate : Cell = candidates[i].c;
            if( candidate.solider == null )
            {
                if( candidate.isObstacle ) continue;
                else return candidate.index;
            }
            else
            {
                if( candidate.solider.army == army ) continue;
                else
                {
                    if( candidate.solider.kill( this ) ) candidate.solider = null;
                    return cell.index;
                }
            }
        }
        return cell.index;
    }

    private function SortCandidates( a:Object, b:Object ):int {
        var r : Number = 1+( ( Math.random()-0.5)/4);
        if(r*a.d > b.d ) return 1;
        if(r*a.d < b.d ) return -1;
        return 0;
    }

    private function D( cell:Cell ) : Number
    {
        var dx = Math.abs(cell.x - army.x);
        var dy = Math.abs(cell.y - army.y);
        return Math.max( dx,dy );
    }

    public function kill( attacker:Solider ):Boolean
    {
        if( Math.random() > 0.5 ) stamina--;
        return stamina <= 0;
    }
}
}
