/**
 * Created with IntelliJ IDEA.
 * User: wizzard
 * Date: 14.07.14
 * Time: 10:34
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.utils.ByteArray;

public class BattleField {
    public var board : Vector.<Cell> = new Vector.<Cell>();
    public var soliders : Vector.<Solider> = new Vector.<Solider>();
    private var width : uint;
    private var height : uint;

    public function BattleField( w : uint, h: uint, a : Array ) {
        width = w;
        height = h;

        board = new Vector.<Cell>();
        while( board.length < width*height ) board.push( new Cell() );

        var n : uint = 0;
        for( var i in a )
            for( var j in a[i].soliders )
            {
                board[n++].solider = a[i].soliders[j];
                soliders.push( a[i].soliders[j] );
            }

        board.sort( shuffle );

        for( var index : uint = 0; index < board.length; index++ )
        {
            var cell : Cell = board[index];
            if( cell.solider != null ) cell.solider.cell = cell;
            var y : uint = Math.floor( index/width );
            var x = index - y*width;
            cell.siblings[0] = x>0         ? board[index-1]        : new Cell( true );
            cell.siblings[1] = y>0         ? board[index-width]    : new Cell( true );
            cell.siblings[2] = x<width-1   ? board[index+1]        : new Cell( true );
            cell.siblings[3] = y<height-1  ? board[index+width]    : new Cell( true );

            cell.siblings[4] = x>0 && y>0  ? board[index-1-width]        : new Cell( true );
            cell.siblings[5] = y>0 && x<width-1        ? board[index-width+1]    : new Cell( true );
            cell.siblings[6] = x<width-1 && y<height-1  ? board[index+1+width]        : new Cell( true );
            cell.siblings[7] = x>0 && y<height-1  ? board[index+width-1]    : new Cell( true );

            cell.index = index;
            cell.x = x;
            cell.y = y;
        }
    }

    private function shuffle( a:Cell, b:Cell ): int
    {
        var r : Number = Math.random();
        if( r>0.5 ) return 1;
        if( r<0.5 ) return -1;
        return 0;
    }

    public function Step() : void
    {
        for( var n : uint = 0; n<soliders.length; n++ )
        {
            var cell : Cell = soliders[n].cell;
            var i : uint = soliders[n].Move();
            if( i != cell.index )
            {
                board[i].solider = cell.solider;
                cell.solider = null;
                soliders[n].cell = board[i];
            }
        }
    }

    public function get pixels() : ByteArray
    {
        var b : ByteArray = new ByteArray();
        for( var i in board ) b.writeUnsignedInt( board[i].pixel );
        b.position = 0;
        return b;
    }
}
}
