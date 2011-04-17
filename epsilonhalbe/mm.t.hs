import TAP
-- http://testanything.org/wiki/index.php/HaskellTapModule
-- http://svn.solucorp.qc.ca/repos/solucorp/JTap/trunk/TAP.hs
import Mastermind

main = runTests $ do
    planTests 2

    let list_of_randoms = [2,2,3,5]

    is (reds [2,2,3,4] list_of_randoms) [0,0,0] $ Just "correct number and position"
    is (whites [1,4,2,2] list_of_randoms) [1,1] $ Just "correct number, but wrong position"
