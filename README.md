# Overview
Analysing JSON data has long been a major headache for large companies.

For example, Uber is ingesting millions of logs per second and Ebay stores multiple petabytes of logs each day - all in the form of JSON. Building analytics with this data is extremely complicated and inefficient.

The following code outlines a technique to ingest JSON data and format it in a fixed schema - even if the structure of the JSON changes - in Clickhouse. 

# Setup 

### 1: Download the binary
ClickHouse runs natively on Linux, FreeBSD and macOS, and runs on Windows via the WSL. The simplest way to download ClickHouse locally is to run the following curl command. It determines if your operating system is supported, then downloads an appropriate ClickHouse binary:

```bash
curl https://clickhouse.com/ | sh
```

### 2: Start the server
Run the following command to start the ClickHouse server:

```bash
./clickhouse server
```

### 3: Start the client
Use the ```clickhouse-client``` to connect to your ClickHouse service. Open a new Terminal, change directories to where your ```clickhouse``` binary is saved, and run the following command:

```bash
./clickhouse client
```

You should see a smiling face as it connects to your service running on localhost:

```bash
my-host :)
```

### 4: Create a table and Insert Data

See directory ```clickhouse```