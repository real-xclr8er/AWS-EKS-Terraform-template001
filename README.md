# AWS-EKS-Terraform-template001

Baseline EKS Terraform setup with 1 node group, Prometheus, Grafana.

## Prerequisites

- Terraform (>= 1.0)
- AWS CLI (configured with appropriate credentials)

## Project Structure

- `versions.tf`: Specifies the required Terraform version and provider versions.
- `variables.tf`: Defines the input variables for the Terraform configuration.
- `provider.tf`: Configures the AWS, Kubernetes, and Helm providers.
- `main.tf`: Main Terraform configuration file that sets up the VPC and EKS cluster.
- `node_group.tf`: Configures the EKS node group and associated IAM policies.
- `outputs.tf`: Defines the outputs of the Terraform configuration.

## Usage

1. Clone the repository:
    ```sh
    git clone <repository-url>
    cd terraform-aws-eks
    ```

2. Initialize Terraform:
    ```sh
    terraform init
    ```

3. Review the plan:
    ```sh
    terraform plan
    ```

4. Apply the configuration:
    ```sh
    terraform apply
    ```

5. Configure kubectl:
    ```sh
    aws eks update-kubeconfig --region <aws_region> --name <cluster_name>
    ```

## Variables

Refer to `variables.tf` for the list of configurable variables and their default values.

## Outputs

Refer to `outputs.tf` for the list of outputs provided by this configuration.

## Monitoring Setup

This configuration includes Prometheus and Grafana for monitoring. The monitoring tools are deployed in the `monitoring` namespace by default.

## Cleanup

To destroy the resources created by this configuration:
```sh
terraform destroy
```

## Upload to GitHub

1. Create a new repository on GitHub.

2. Initialize a local Git repository:
    ```sh
    git init
    ```

3. Add the remote GitHub repository:
    ```sh
    git remote add origin <repository-url>
    ```

4. Add all files to the repository:
    ```sh
    git add .
    ```

5. Commit your changes:
    ```sh
    git commit -m "Initial commit"
    ```

6. Push the changes to GitHub:
    ```sh
    git push -u origin main
    ```

## License

This project is licensed under the MIT License.
