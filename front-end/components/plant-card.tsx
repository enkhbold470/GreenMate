import Image from "next/image";

export default function PlantCard({
  name,
  image,
  prediction,
}: {
  name: string;
  image: string;
  prediction: string;
}) {
  return (
    <div className="bg-white rounded-3xl shadow-lg overflow-hidden">
      <Image
        src={image}
        alt={name}
        className="w-full h-52 object-cover"
        width={400}
        height={400}
      />
      <div className="p-4">
        <h3 className="text-fern_green-DEFAULT font-semibold text-lg">
          {name}
        </h3>
        <p className="text-asparagus-600 text-sm">Prediction: {prediction} </p>
      </div>
    </div>
  );
}
