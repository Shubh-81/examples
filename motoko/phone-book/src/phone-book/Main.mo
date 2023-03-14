import Map "mo:base/HashMap";
import Text "mo:base/Text";

actor {

  type Name = Text;
  type Phone = Text;

  type Entry = {
    desc: Text;
    phone: Phone;
  };

  let phonebook = Map.HashMap<Name, Entry>(0, Text.equal, Text.hash);  // Entries Corresponding to Name.
  let phoneToName = Map.HashMap<Phone, Name>(0, Text.equal, Text.hash); //To get Name from Phone Number.

  public func insert(name : Name, entry : Entry): async Text {
    if(phonebook.get(name)==null) {   //To check if name already exsists.
      var nameFromPhone : Name = switch(phoneToName.get(entry.phone)) {   //Checking if phone number already exsists.
        case null "";
        case (?result)  result;
      };
      if(nameFromPhone=="") {
          phonebook.put(name, entry);
          phoneToName.put(entry.phone,name);
          return "Successfully Added Entry.";
      }
      else {
        return "Error : Entry already exsists.";
      }
    }
    else {
      return "Error: Entry already exsists.";
    }
  };

  public query func lookup(text : Text) : async ?Entry {
      var t : Name = "";
      var name : Name = switch(phoneToName.get(text)) {   //Retrieving name from text (If phone number if given as input)
        case null t;
        case (?result)  result;
      };
      if(name!="")  return phonebook.get(name); //If name from phone number is not null then it's corresponding entry is returned.
      return phonebook.get(text);  //If name from phone number is null then the entry corresponding to given input is returned.
  };

  public func deleteEntry(text:Text) : async Text {
    if(phonebook.get(text)!=null) { //Checking that if given input is present in phone book.
      var phone: Phone = switch(phonebook.get(text)) {
        case null "";
        case (?result)  result.phone;
      };
      phoneToName.delete(phone);
      phonebook.delete(text);
      return "Successfully Deleted Entry";
    }
    else  { 
      var t : Name = "";
      var name : Name = switch(phoneToName.get(text)) { //Retreiving name from phone number.
        case null t;
        case (?result)  result;
      };
      if(name!="") { //If name is not null then entry corresponding to that name is deleted.
        phoneToName.delete(text);
        phonebook.delete(name);
        return "Successfully Deleted Entry."
      }
      else {  //Entry is not present as both phone number and name input has been checked.
        return "Entry Not Found.";
      }
    }
  };
};
