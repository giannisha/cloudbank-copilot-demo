<script lang="ts">
	import { Table, tableMapperValues } from '@skeletonlabs/skeleton';

	export let data;

	const accountsTransactionTableSource = {
		head: ['ID', 'Category', 'Type', 'Description', 'Amount'],
		body: tableMapperValues(data.accountsTransactions?.slice(0, 5) ?? [], [
			'id',
			'category',
			'type',
			'description',
			'amount'
		])
	};

	const cardsTransactionsTableSource = {
		head: ['ID', 'Category', 'Type', 'Description', 'Amount'],
		body: tableMapperValues(data.cardsTransactions?.slice(0, 5) ?? [], [
			'id',
			'category',
			'type',
			'description',
			'amount'
		])
	};
</script>

<div class="flex flex-col gap-5 p-3 mt-2">
	<h1 class="h3 self-end mr-2"><span class="gradient-heading">Hello, {data.user?.name}</span></h1>
	<div class="card p-4 mt-4">
		<div class="flex flex-row align-middle">
			<h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
				Account Transactions
			</h5>
		</div>

		{#if data.accountsTransactions}
			<div class="flex-col gap-6">
				<Table source={accountsTransactionTableSource} />
			</div>
		{:else}
			<p>No transactions found</p>
		{/if}
	</div>

	<div class="card p-4">
		<div class="flex flex-row align-middle">
			<h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
				Card Transactions
			</h5>
		</div>

		{#if data.accountsTransactions}
			<div class="flex-col gap-6">
				<Table source={cardsTransactionsTableSource} />
			</div>
		{:else}
			<p>No transactions found</p>
		{/if}
	</div>
</div>
