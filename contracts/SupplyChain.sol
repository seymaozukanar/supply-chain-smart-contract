pragma solidity >=0.8.17;

contract supplyChain{

    uint16 product_id = 0;
    uint16 participant_id = 0;

    struct product{
        string productName;
        uint16 ownerId;
        address ownerAddress;
    }

    mapping (uint16 => product) public products;

    struct participant{
        string username;
        string password;
        address participantAddress;
        string participantType;
    }

    mapping (uint16 => participant) public participants;

    struct ownership{
        address ownerAddress;
        uint16 ownerId;
        uint16 productId;
        string transactionDate;
    }

    mapping (uint16 => ownership) public ownerships;

    function addProduct(uint16 _ownerId, string memory _name) public returns (bool){
        if (bytes(participants[_ownerId].participantType).length == bytes("Manufacturer").length){
            require(keccak256(abi.encodePacked(participants[_ownerId].participantType)) == keccak256("Manufacturer"),
                    "Only manufacturers can add products!");
            uint16 productId = product_id++;
            products[productId].productName = _name;
            return true;
        }
        else
            return false;
    }

    function addParticipant(string memory _username, string memory _password, address _address, string memory _type) public returns (uint16){
        uint16 participantId = participant_id++;
        participants[participantId].username = _username;
        participants[participantId].password = _password;
        participants[participantId].participantAddress = _address;
        participants[participantId].participantType = _type;

        return participantId;
    }

    function getProduct(uint16 _productId) public view returns (string memory, uint16, address){
        product memory _product = products[_productId];
        return (_product.productName,
                _product.ownerId,
                _product.ownerAddress);
    }

    function getParticipant(uint16 _participantId) public view returns (string memory, address, string memory){
        participant memory _participant = participants[_participantId];
        return (_participant.username,
                _participant.participantAddress,
                _participant.participantType);
    }

    function getOwner(uint16 _productId) public view returns (address){
        return ownerships[_productId].ownerAddress;
    }
}
