require 'json'
require 'aws-sdk-eventbridge'

def lambda_handler(event:, context:)

    order_details = {
        orderNumber: "123456",
        productId: "shoe_007",
        price: 130,
        customer: {
            name: "Alistair Sutherland",
            customerId: "987654321",
            address: "83 Princes Street, Edinburgh"
        }
    }

    event_bridge = Aws::EventBridge::Client.new(region: 'eu-west-1')

    resp = event_bridge.put_events({
        entries: [
            {
                source: "Order Service",
                detail_type: "New Order",
                detail: order_details.to_json,
                event_bus_name: "orders"
            },
        ]
    })
    puts resp.entries
    { statusCode: 200, body: JSON.generate('Hello from Lambda')}
end