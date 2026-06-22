1. Compile the Smart Contract
Compile the Solidity code to generate the required network artifacts and ABI mappings:

npx hardhat compile

Deployment & Running Locally
To deploy and test the contract locally, you will need two separate terminal windows open simultaneously.

Step 1: Start the Local Blockchain Node

Bash

npx hardhat node

Leave this terminal running. Do not close it or execute other commands here.

Step 2: Deploy the Contract
Open a second terminal window, ensure you are in the project root directory, and run the deployment script targeting your local network:

Bash

npx hardhat run scripts/deploy.js --network localhost

Upon completion, copy the printed deployment contract address (e.g., 0x5FbDB2315678afecb367f032d93F642f64180aa3).

Interactive Testing via Hardhat Console
You can manually interact with your live local contract by launching the interactive JavaScript runtime console.

1. Launch the Console
In your second terminal, execute:

Bash

npx hardhat console --network localhost

2. Initialize the Contract Environment
Inside the interactive prompt (>), paste the following initialization sequence to fetch the environment network context and attach your contract factory instance:

JavaScript
// Establish network connection context
const connection = await hre.network.create(); const { ethers } = connection;

// Load the Contract Factory
const Voting = await ethers.getContractFactory("Voting");

// Attach to your deployed contract address (Replace with your actual address)
const voting = await Voting.attach("YOUR_DEPLOYED_ADDRESS_HERE");

3. Execution Commands & Interactions

Add Candidates (Restricted to Election Official)

JavaScript

await voting.addCandidate("Alice");
await voting.addCandidate("Bob");

Cast a Vote (Account 1)
JavaScript

await voting.vote(1);

Verify Vote Count Results
JavaScript

(await voting.getVotes(1)).toString(); // Returns '1'

Testing Validation 
JavaScript

await voting.vote(1); Return Error with a message "You have already voted"
or 
await voting.vote(2); same thing as the above