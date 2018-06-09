Marlin
======

Marlin is a Siacoin Stratum miner for OpenCL and CUDA devices developed by [SiaMining](https://siamining.com). It is designed to be fast, lightweight and easy to use.

## Key Features

* Native Stratum support.
* Lightning fast with both AMD and Nvidia GPUs.
* Multiple built-in kernels.
* Kernel and intensity can be set separately for each device.
* Detection of hardware errors.
* Detailed share reporting, including difficulties and reject reasons.

## Usage

```
/usr/local/bin/marlin -u YourPayoutAddress.WorkerName -I 28
```

* By default, the miner connects to one of SiaMining.com's Stratum servers. Use option `-H` to connect to a specific server.
* By default, all OpenCL GPUs are used. To use a specific subset of OpenCL devices, use option `-d` with a comma-separated list of device IDs. The full list of IDs is printed every time the miner is started. Note that Nvidia GPUs should be listed twice, once as CUDA and once as OpenCL devices; the OpenCL interface is disabled by default for these GPUs, as CUDA usually gives better results.
* The default intensity is 24. You can use option `-I` to adjust it. You can also specify a different intensity for each device by passing a comma-separated list.
* You can use option `-K` to use a kernel other than the default one; like with intensity, you can specify a different kernel for each device by passing a comma-separated list. Run a benchmark with option `--benchmark` to see all available kernels for a given device.

To see all supported options:

```
/usr/local/bin/marlin -h
```

Run in background with other pools:

```console
$ docker run -d --device /dev/kfd --device /dev/dri --name CONTAINER_NAME sleeck/marlin:latest -H POOL_ADDRESS -u USERNAME.WORKER_NAME -p WORKER_PASSWORD -I 28
```

## Concepts

### Difficulty

The miner conforms to the Sia definition of difficulty (which is not the definition used by Stratum at the protocol level). SI prefixes are used to display difficulties in compact form. For instance, 4.2G = 4.2 × 10<sup>9</sup> = 4,200,000,000.

When a solution is submitted, the miner shows two difficulties:

* The minimum difficulty for which the found hash is a solution.
* The difficulty that was required to solve a share.

### Hash rates

All hash rates are expressed in millions of hashes per second (MH/s). When a solution is accepted, the miner displays the hash rate of the device that found it.

Once every minute, a global report is printed. This report includes:

* The number of accepted (`A`) and rejected (`R`) solutions.
* The number of hardware errors (`E`).
* The current hash rate of each device.
* The current total hash rate.
* The average total hash rate since the program was started.