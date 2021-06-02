# S3 Remote State Bucket Logging Bucket Module

This is the bootstrap that manages the logging buckets
for changes registered through other bootstraps.

Specifically, 
1. Any given bootstrap needs an S3 Bucket to store its state
1. Among other things, that bucket needs versioning and logging for changes
1. Logging requires yet another bucket
1. This module is for creating the buckets used for logging of state buckets.

All remote state logging buckets use a standard key 
for logging.  `rsblogs/`