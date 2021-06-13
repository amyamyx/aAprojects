// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  var Piece = require("./piece");
}
// DON'T TOUCH THIS CODE

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  let grid = new Array(8);

  for (let i = 0; i < 8; i++) {
    grid[i] = new Array(8)
  };

  [grid[3][4], grid[4][3]] = [new Piece("black"), new Piece("black")];
  [grid[3][3], grid[4][4]] = [new Piece("white"), new Piece("white")];

  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  return pos.every(el => el < 8 && el >= 0);
};

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  [x, y] = pos
  if (this.isValidPos(pos)) return this.grid[x][y];
  throw new Error("Not valid pos!");
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  if (!this.getPiece(pos)) return undefined;
  return this.getPiece(pos).color === color;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  return !!this.getPiece(pos)
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns an empty array if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns empty array if it hits an empty position.
 *
 * Returns empty array if no pieces of the opposite color are found.
 */
Board.prototype._positionsToFlip = function(pos, color, dir, piecesToFlip){
  if (!this.isValidPos(pos)) return [];
  if (!piecesToFlip) return this._positionsToFlip(newPos(pos, dir), color, dir, []);
  if (!this.isOccupied(pos)) return [];

  let piece = this.getPiece(pos);
  if (piece.color === color && piecesToFlip.length > 0) return piecesToFlip;
  if (piece.color !== color) piecesToFlip.push(pos);

  return this._positionsToFlip(newPos(pos, dir), color, dir, piecesToFlip);
};

function newPos(pos, dir) {
  [x, y, dx, dy] = pos.concat(dir)
  return [x + dx, y + dy]
}

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if (this.isOccupied(pos)) return false;
  return Board.DIRS.some(dir => this._positionsToFlip(pos, color, dir).length > 0);
};

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (!this.validMove(pos, color)) throw new Error("Invalid move!");
  if (this.isOccupied(pos)) throw new Error("Occupied");

  this._placePiece(pos, color);
  Board.DIRS.forEach(dir => {
    let posToFlip = this._positionsToFlip(pos, color, dir);
    posToFlip.forEach(flipPos=> this.getPiece(flipPos).flip())
  })
};

Board.prototype._placePiece = function(pos, color) {
  [x, y] = pos;
  this.grid[x][y] = new Piece(color);
}

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) { 
  let validPos = [];
  for (let x = 0; x < 8; x++) {
    for (let y = 0; y < 8; y++) {
      if (this.validMove([x, y], color)) validPos.push([x, y]);
    };
  };

  return validPos;
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return this.validMoves(color).length > 0;
};



/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return !(this.hasMove("white") || this.hasMove("black"));
};




/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  this.grid.forEach(row => {
  })
};


// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  module.exports = Board;
}
// DON'T TOUCH THIS CODE