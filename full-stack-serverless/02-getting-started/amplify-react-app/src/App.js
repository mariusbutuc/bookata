// React hooks
import React, { useState, useEffect } from 'react';

// API category from AWS Amplify
import { API } from 'aws-amplify';

import './App.css';

function App() {
	// Create `coins` variable and set to empty array
	const [coins, updateCoins] = useState([]);
	// Create additional state to hold user input for `limit` and `start` properties
	const [input, updateInput] = useState({ limit: 5, start: 0 });

	function updateInputValues(type, value) {
		updateInput({ ...input, [type]: value });
	}

	// Update to use `limit` and `start` properties
	async function fetchCoins() {
		const { limit, start } = input;
		const data = await API.get(
			'cryptoapi',
			`/coins?limit=${limit}&start=${start}`
		);
		updateCoins(data.coins);
	}

	// Call fetchCoins function when component loads
	useEffect(() => {
		fetchCoins();
		// FIXME: Understand the dependency array suggestion below and the implications of ignoring it.
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, []);

	return (
		<div className="App">
			{coins.map((coin, index) => (
				<div key={index}>
					<h2>
						{coin.name} - {coin.symbol}
					</h2>
					<h5>${coin.price_usd}</h5>
				</div>
			))}

			<input
				onChange={(e) => updateInputValues('limit', e.target.value)}
				placeholder="limit"
			/>
			<input
				onChange={(e) => updateInputValues('start', e.target.value)}
				placeholder="start"
			/>

			<button onClick={fetchCoins}>Fetch Coins</button>
		</div>
	);
}

export default App;
