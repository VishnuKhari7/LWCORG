public class BankClass {
    //*****FOR ATM WITHDRAWAL***
    public void withdrawMoney(Integer userInputATM){
      system.debug('this method is for ATM');
         system.debug('userInputATM is'+userInputATM);
    }
    //***FOR ONLINE BANING WITHDRAWAL***
    public void withdrawMoney(string userInputPSWD,string userInputUserID ){
             system.debug('this method is for Online Banking');
         system.debug('userInput PSW & ID is'+userInputPSWD +' and '+userInputUserID);
    }
    //***FOR UPI WITHDRAWAL***
    public void withdrawMoney(string userInputUPIID ){
             system.debug('this method is for UPI');
         system.debug('userInputUPIID is'+userInputUPIID);
    }
    
}