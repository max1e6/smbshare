# smbshare
A simple docker container to share a folder on the network

## A little bit of history

In 2017 I was setting up an office for a new small law firm. I proudly explain to the partners, "Your firm is going to be in the cloud. Any millennial you hire will be thrilled with the technology of the firm."

Then the first thing they ask me to do is setup scanning from the MFC, which requires a network share.

Doh!

At the time I setup a share on a Windows workstation (a pain), so when the firm moved offices a year ago I took the opportunity to recreate this functionality in a docker container.

## Use Case(s)

This docker container was created so I could easily connect a multifunction copier to a network share, so people could scan a document at the MFC and then pick it up on their computer.

It could also be used a simple network share to transfer files between computers.

While it could be setup as a file server it was never intended for long term storage of files, just a place to drop a file until it could copied and stored in a proper place either on-prem or in the cloud. As such it does implement fine grained security. It is appropriate for use were you want or need the information to be accessible vs. protected and secure.

## 
