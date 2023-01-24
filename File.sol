pragma solidity ^0.8.0;

contract FileStorage {
    mapping(bytes32 => bytes) files;
    mapping(bytes32 => address) fileOwners;

    function storeFile(bytes32 _fileHash, bytes memory _file) public {
        files[_fileHash] = _file;
        fileOwners[_fileHash] = msg.sender;
    }

    function getFile(bytes32 _fileHash) public view returns (bytes memory) {
        require(fileOwners[_fileHash] == msg.sender || msg.sender.isAdmin(), "Access denied.");
        return files[_fileHash];
    }

    function deleteFile(bytes32 _fileHash) public {
        require(fileOwners[_fileHash] == msg.sender || msg.sender.isAdmin(), "Access denied.");
        delete files[_fileHash];
        delete fileOwners[_fileHash];
    }

    function grantAccess(bytes32 _fileHash, address _user) public {
        require(fileOwners[_fileHash] == msg.sender || msg.sender.isAdmin(), "Access denied.");
        fileOwners[_fileHash] = _user;
    }
}