// Setup ActionCable consumer
import { createConsumer } from "@rails/actioncable"

// Export the consumer so other channels can import it
const consumer = createConsumer()
export default consumer
