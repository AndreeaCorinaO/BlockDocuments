pragma solidity ^0.5.0;

contract DocumentsBlock {
  //storing the data in a struct
  struct Document {
    uint id;
    address editor;
    string title;
    string contain;
    bool status;
  }

  mapping (uint => Document) public documents;
  // state variables
  uint public docsCounter;

  // events
  event LogAddDoc(
    uint indexed _id,
    address indexed _editor,
    string _title,
    string _contain,
    bool _status
  );
  event LogEditDoc(
    uint indexed _id,
    address indexed _editor,
    string _title,
    string _contain,
    bool _status
  );
  event DocsCompleted(
      uint _id,
      bool status
       );

  // add a document
  function AddDoc(string memory _title, string memory  _contain, bool _status) public {
    // a new document added
    docsCounter++;

    // store this doc
    documents[docsCounter] = Document(
      docsCounter,
      msg.sender,
      _title,
      _contain,
      _status
    );

    emit LogAddDoc(docsCounter, msg.sender,  _title, _contain, _status);
  }
   function docsStatus(uint _id) public {
    Document memory document = documents[_id];
    document.status = !document.status;
    documents[_id] = document;
    emit DocsCompleted(_id, document.status);
  }

  // fetch the number of documents in the contract
  function getNumberOfDocs() public view returns (uint) {
    return docsCounter;
  }
  //fetch and return all docs IDs
  function getDocs() public view returns (uint[] memory) {
    // prepare output array
    uint[] memory docsIds = new uint[](docsCounter);

    uint numberOfDocs = 0;
    // iterate over documents
    for(uint i = 1; i <= docsCounter;  i++) {
      // keep the ID if the doc is still available to edit
      if(documents[i].status != false) {
        docsIds[numberOfDocs] = documents[i].id;
        numberOfDocs++;
      }
    }

    // copy the docsIds array into a smaller array
    uint[] memory forEdit = new uint[](numberOfDocs);
    for(uint j = 0; j < numberOfDocs; j++) {
      forEdit[j] = docsIds[j];
    }
    return forEdit;
  }

  // edit a doc
  function editDocs(uint _id, string memory _newcontain) public {
    // we check whether there is an doc for edit
    require(docsCounter > 0, "documents does not exist");

    // we check that the documents exists
    require(_id > 0 && _id <= docsCounter, "id does not exists");

    //we retrieve the doc
    Document storage document = documents[_id];

    // we check that the doc has not been edit yet
    require(document.status == false, "documents not avalilabe for editing");

// keep editor information
    document.editor = msg.sender;

    //we update the  updated contain
    document.contain = _newcontain;

    // trigger the event
    emit LogEditDoc(_id, document.editor, document.title, document.contain, document.status);
  }
}