public class FirstApex {
   public  String Name; //class var
   public  Integer Age;
  
    public FirstApex(String Name, Integer Age){//local vars
        //data initiate
      this.Name= Name;
       this.age= Age;
    // Name = 'AKSHAYA';
    // Age = 5;
    }
    public void FirstMethod(){ //non static method without parameters
       String strVar='var from first method'; //local variable
        system.debug(system.today() );
         system.debug(Name);
        system.debug(Age);
        privateMethod();
    }
    public void secondMethod(){ //non static method without parameters
      // strVar = 'changed val from secondMethod';
        system.debug(system.today() );
         system.debug(Name);
        system.debug(Age);
    }
    private void privateMethod(){ //non static method without parameters
      // strVar1 = 'private';
        system.debug('private method.....');
         
    }
}