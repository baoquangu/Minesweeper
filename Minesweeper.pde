import de.bezier.guido.*;

public final static int NUM_mines = 40;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList < MSButton > mines = new ArrayList < MSButton > (); //ArrayList of just the minesweeper buttons that are mined

void setup() {
size(400, 400);
textAlign(CENTER, CENTER);

Interactive.make(this);
buttons = new MSButton[NUM_ROWS][NUM_COLS];
 for(int j = 0; j < NUM_ROWS; j++) {
 for(int k = 0; k < NUM_COLS; k++) {
 buttons[j][k] = new MSButton(j, k);
 }
}
setmines();
}

public void draw(){
background(0);
if(isWon())
 displayWinningMessage();
}

public void setmines() {
for(int i = 0; i < NUM_mines; i++) {
 int aRow = (int)(Math.random() * NUM_ROWS);
 int aCol = (int)(Math.random() * NUM_COLS);
 if (!mines.contains(buttons[aRow][aCol])) {
 mines.add(buttons[aRow][aCol]);
 }
}
}

public class MSButton {
private int r, c;
private float x, y, width, height;
private boolean clicked, marked;
private String label;

public MSButton(int rr, int cc) {
 width = 400 / NUM_COLS;
 height = 400 / NUM_ROWS;
 r = rr;
 c = cc;
 x = c * width;
 y = r * height;
 label = "";
 marked = clicked = false;
 Interactive.add(this); 
}
public boolean isMarked() {
 return marked;
}
public boolean isClicked() {
 return clicked;
}
public void setClicked(boolean cClicked)
{
 clicked = cClicked;
}

 public void mousePressed () 
{
 if(mouseButton == LEFT)
 {
 if(clicked == false)
 {
 clicked = true;
 if(keyPressed == true)
 {
 marked = !marked;
 }
 else if(mines.contains(this))
 {
 displayLosingMessage();
 }
 else if(countmines(r,c)>0)
 {
 label = label + countmines(r,c);
// println("label");
 }
 else
 {
 for(int i=-1;i<2;i++)
 {
 for(int j=-1;j<2;j++)
 {
 if(isValid(r+i,c+j)==true)
 {
 if(buttons[r+i][c+j].isClicked()==false)
 {
 buttons[r+i][c+j].mousePressed();
 }
 }
 }
 }
 }
 }
 }
 if(mouseButton==RIGHT)
 {
 if(clicked == false)
 {
 marked=!marked;
 }
 }
}


public void draw() {
 if(marked)
 fill(155,0,0);
 else if(clicked && mines.contains(this))
 fill(155, 0, 0);
 else if(clicked)
 fill(150);
 else
 fill(50);

 rect(x, y, width, height);
 fill(0);
 text(label, x + width / 2, y + height / 2);
}
public void setLabel(String newLabel) {
 label = newLabel;
}
public boolean isValid(int r, int c) {
 if ((r > -1 && r < NUM_ROWS) && (c > -1 && c < NUM_COLS)) {
 return true;
 }
 return false;
}
 public int countmines(int row, int col)
{
 int nummines = 0;
 for(int i=-1;i<2;i++){
 for(int j=-1;j<2;j++){
 if(isValid(row+i,col+j)==true){
 if(mines.contains(buttons[row+i][col+j])){
 nummines++;
 }
 }
 }
 }
 return nummines;
 }
}

public boolean isWon(){
int boom = 0;
for(int i = 0; i < mines.size(); i++){
 if(mines.get(i).isMarked() == true)
 {
 boom++;
 }
}
if(boom == mines.size()){
 return true;
}
for(int i = 0;i < mines.size(); i++)
{
 if(mines.get(i).isClicked() == true)
 {
 displayLosingMessage();
 }
}
 return false;
}
public void displayLosingMessage() {
 for(int i=0;i<mines.size();i++){
 mines.get(i).setClicked(true);
 }
 
 
 buttons[9][8].setLabel("B");
 buttons[9][9].setLabel("Y");
 buttons[9][10].setLabel("E");

 
}
public void displayWinningMessage() {
 buttons[9][8].setLabel("N");
 buttons[9][9].setLabel("I");
 buttons[9][10].setLabel("C");
 buttons[10][8].setLabel("E");
}

