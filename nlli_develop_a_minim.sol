pragma solidity ^0.8.0;

contract ServiceTracker {
    struct Service {
        string serviceName;
        string serviceProvider;
        string status; // "online" or "offline"
        uint256 uptime; // in seconds
        uint256 downtime; // in seconds
    }

    mapping (string => Service) public services;

    function addService(string memory _serviceName, string memory _serviceProvider) public {
        services[_serviceName] = Service(_serviceName, _serviceProvider, "online", 0, 0);
    }

    function updateServiceStatus(string memory _serviceName, string memory _status) public {
        Service storage service = services[_serviceName];
        if (_status == "online") {
            service.uptime += block.timestamp - service.downtime;
        } else {
            service.downtime = block.timestamp - service.uptime;
        }
        service.status = _status;
    }

    function getServiceInfo(string memory _serviceName) public view returns (string memory, string memory, string memory, uint256, uint256) {
        Service storage service = services[_serviceName];
        return (service.serviceName, service.serviceProvider, service.status, service.uptime, service.downtime);
    }
}