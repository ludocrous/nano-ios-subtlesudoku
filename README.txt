README File for SubtleSudoku

Overview:

A simple Sudoku game that accesses a list of puzzles stored in a DynamoDB table on Amazon Web Services hosting environment. 
The user can preview a puzzle's layout and then choose to accept the challenge. On preview the app will solve the puzzle 
and provide feedback as to whether the app can be solved by pure process of elimination or whether trial and error is required.

Once a puzzle is selected it is added to the challenge list, where challenges including the user's progress are 
stored using Core Data. The user is able to work on one challenge at a time to attempt finding a solution.

Thanks and credit goes to Peter Norvig whose work formed the basis for the solution code.
http://norvig.com/sudoku.html

INSTALLATION:

Requirements: 
 - An installation of Cocoa Pods is required.
 - Amamzon Web Services SDK (installed via CocoaPods)

The required AWS SDK components can be installed by running the CocoaPods pod file included in the base directory.

USER GUIDE:

Challenge List:
- On opening of the App the user is presented with a list of challenges (accepted puzzles) that are currently being attempted.
- On first run sample data (comprised of 1 easy and 1 hard puzzle) will be pre-populated to the Core Data context.
- These challenges may be deleted by either swiping left on the table entry or using the Edit button to delete.
- Each entry shows the unique name of the original puzzle as well as percentage complete (this is measured excluding the original given values).
- In order select a new puzzle - select the + button in the top right-hand corner to be take to the "Puzzle List".
- To continue working on a challenge, simply select the challenge to be taken to the "Challenge Detail" screen.

Puzzles List:
- This list shows the puzzles stored in the AWS DynamoDb table.
- The list shows the unique name of the puzzle and whether or not the challenge of this puzzle has been accpeted (ie. it is an active challenge)
- To preview any puzzle select the row.

Puzzle Preview:
- This view will show a static grid representation of the puzzle (no interaction).
- The detail panel will show how many cells remain unresolved. 
- In addition, as the puzzle has already been solved by the time its presented, the details show whether the puzzle can be solved by simple process of elimination or trial and error.
- (Process of elimination puzzles simply require the rote application of Sudoku rules of only 1 instance of each number in a row, column or square of 9.)
- (Trial and error solutions mean that at some point the user will have to guess a value)
- To accept a puzzle as a challenge and add it the list simply select the "Accept Challenge" button.

Challenge Detail:
- This screen is used to interact with the puzzle and attempt to solve it.
- The initial puzzle value are displayed in Black.
- The user can select any cell that does not contain a given value.
- The will enable the selection bar and allow the user to set a value in the cell. (Underscore clears set value)
- User values set in the cell will be displayed in Blue.
- This process is repeated until the puzzle is completed.
- If easy mode is selected, all input will be compared to the known solution and incorrect values will be marked in Red.
- The status of the "Easy Mode" button is persisted between sessions using NSUserDefaults
- The "Reset" button will reset the puzzle to its initial state.

Good luck !


