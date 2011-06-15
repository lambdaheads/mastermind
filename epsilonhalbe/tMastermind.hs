import TAP
-- http://testanything.org/wiki/index.php/HaskellTapModule
-- http://svn.solucorp.qc.ca/repos/solucorp/JTap/trunk/TAP.hs
import Mastermind

main = runTests $ do
    planTests 10

    let list_of_randoms = [2,2,3,5]

    is (reds [2,2,3,4] list_of_randoms) [0,0,0] $
        Just "correct number and position"
    is (reds [] list_of_randoms) [] $
        Just "correct num and pos - fringe case: []"
    is (reds [2,2,2,2,2] list_of_randoms) [0,0] $
        Just "correct num and pos - fringe case:\
              \input list longer than list_of_randoms"

    is (whites [1,4,2,2] list_of_randoms) [1,1] $
        Just "correct number, but wrong position"
    is (whites [] list_of_randoms) [] $
        Just "correct num, wrong pos - fringe case: []"
    is (whites [1,1,2,2,2] list_of_randoms) [1,1] $
        Just "correct num, wrong pos - fringe case:\
              \input list longer than list_of_randoms"
    is (whites [1,2,1,1,1] [2,1,2,2,2]) [1,1] $ Just "testing the rules"

    is (parseInts "1,2,3,4,5") [1,2,3,4,5] $
        Just "fetch number list from user input"
    is (parseInts "") [] $
        Just "fetch number list from user input - fringe case: \"\""
    is (parseInts "a,b,c,1,2,3") [1,2,3] $
        Just "fetch number list from user input -\
              \fringe case: letters in string"
