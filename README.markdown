# BB-8

BB-8 helps you store your [Terraform](https://www.terraform.io) environments securely, managing the encryption of sensitive files into a git repository, and the encryption keys are shared with other team members using [Voltos](https://voltos.io).

## Installation

Install the gem:

    $ gem install bb8

Also, you'll want to have [Terraform](https://www.terraform.io) and [Voltos](https://voltos.io) installed, plus have Voltos authenticated on your machine.

## Usage

BB-8 manages your infrastructure plans within a single git repository, which has separate folders for each environment (e.g. production, staging, etc). To get going, run the init command with a directory for the git repository (or use `.` for the current directory)

    $ bb8 init servers

Then move into your project's directory (i.e. `cd servers`). You'll want to add an `origin` remote to your git repository where all of this infrastructure configuration will live.

    $ git remote add origin git://...

The next step is to set up an environment:

    $ bb8 environment staging my-servers-staging

The arguments are the name of the environment (in this case, `staging`), and the name of a bundle of Voltos settings. BB-8 will create the latter for you, if you've not already done so.

From this point on, you'll want to issue Terraform commands through BB-8 and a specified environment:

    $ bb8 staging apply
    $ bb8 staging show
    $ bb8 staging destroy

The Terraform configuration is expected along the following lines:

* Common infrastructure for all environments should exist in a file `common.tf` in the root of the project. This is automatically copied to each environment directory.
* Environment-specific infrastructure configuration can live in files within the environment directory.
* Variable files such as `terraform.tfvars` should live in their appropriate environment folders.

Calling a Terraform command via BB-8 goes through this workflow every time:

* Merge the latest changes from the git remote.
* Decrypt all Terraform state and variable files.
* Invoke Terraform.
* Encrypt all Terraform state and variable files.
* Push changes up to the git remote.

The unencrypted versions of the state and variable files are _not_ added to the git repository, thus your secrets remain secret to anyone without access to each environment's Voltos bundle.

To allow others to work on your infrastructure, they'll need access to both the git repository, _and_ the appropriate Voltos bundles.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pat/bb8. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Licence

Copyright (c) 2016, BB-8 is developed and maintained by Pat Allan, and is released under the open MIT Licence.
