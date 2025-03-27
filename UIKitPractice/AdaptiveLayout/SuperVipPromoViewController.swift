import UIKit
import Combine

final class SuperVipPromoViewController: UIViewController {

    private enum Constants {
        static let imageViewSize: CGFloat = 228
        static let detailsButtonColor = UIColor(
            red: 1/255,
            green: 21/255,
            blue: 60/255,
            alpha: 0.68
        )
        static let cashbackLabelColor = UIColor(
            red: 108/255,
            green: 192/255,
            blue: 177/255,
            alpha: 1
        )

        static let viewWidth: CGFloat = 335
    }

    private var cancellables = Set<AnyCancellable>()
    private var viewModel: SuperVipPromoViewModel = .init()
    var topConstraint: NSLayoutConstraint?

    @Autolayout private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    @Autolayout private var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    @Autolayout private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    @Autolayout private var detailsButton: UIButton = {
        let button = UIButton()
        return button
    }()

    @Autolayout private var bannerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()

    @Autolayout private var cashbackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = Constants.cashbackLabelColor
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    @Autolayout private var connectButtonView = SuperVipPromoConnectButtonView()

    @Autolayout private var bottomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        bindPublishers()
        viewModel.sendDataToView()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        bottomButton.isHidden = true

        view.addSubviews([
            imageView,
            mainLabel,
            descriptionLabel,
            detailsButton,
            bannerContainerView,
            cashbackLabel,
            connectButtonView,
            bottomButton
        ])

        
        let detailsButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: Constants.detailsButtonColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        let attributedString = NSMutableAttributedString(
            string: "Подробнее",
            attributes: detailsButtonAttributes
        )
        detailsButton.setAttributedTitle(attributedString, for: .normal)
        connectButtonView.delegate = self

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize),

            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            mainLabel.widthAnchor.constraint(equalToConstant: Constants.viewWidth),

            descriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 96),

            detailsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            detailsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsButton.heightAnchor.constraint(equalToConstant: 24),

            bannerContainerView.topAnchor.constraint(equalTo: detailsButton.bottomAnchor, constant: 26),
            bannerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerContainerView.widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            bannerContainerView.heightAnchor.constraint(equalToConstant: 112),

            cashbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cashbackLabel.heightAnchor.constraint(equalToConstant: 24),
            cashbackLabel.widthAnchor.constraint(equalToConstant: 200),

            connectButtonView.topAnchor.constraint(equalTo: cashbackLabel.bottomAnchor, constant: 8),
            connectButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectButtonView.heightAnchor.constraint(equalToConstant: 64),
            connectButtonView.widthAnchor.constraint(equalToConstant: Constants.viewWidth),

            bottomButton.topAnchor.constraint(equalTo: connectButtonView.bottomAnchor, constant: 12),
            bottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomButton.widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            bottomButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        topConstraint = cashbackLabel.topAnchor.constraint(equalTo: bannerContainerView.bottomAnchor, constant: 60)
        topConstraint?.isActive = true
    }
}

extension SuperVipPromoViewController: SuperViewPromoDelegate {
    func connectButtonStateUpdate() {
        viewModel.changeState()
    }
}

// MARK: Bind publishers

private extension SuperVipPromoViewController {
    private func bindPublishers() {
        Publishers.CombineLatest(viewModel.$modelPublisher, viewModel.$isConnectedState)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model, isConnectedState in
                guard let self = self else { return }
                
                if let model = model {
                    imageView.image = UIImage(named: model.imageName)
                    mainLabel.text = model.mainLabelText
                    descriptionLabel.text = model.descriptionLabelText
                    cashbackLabel.text = model.cashbackLabelText
                    bottomButton.setTitle(model.bottomButtonText, for: .normal)
                    
                    let title = isConnectedState ? "Изменить сейчас" : model.connectButtonText
                    connectButtonView
                        .setTitle(title)
                }
        
                self.topConstraint?.isActive = false
                let padding = isConnectedState ? 8.0 : 60.0
                topConstraint = cashbackLabel.topAnchor.constraint(equalTo: bannerContainerView.bottomAnchor, constant: padding)
                topConstraint?.isActive = true
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                    self.bottomButton.alpha = isConnectedState ? 1.0 : 0.0
                }) { _ in
                    self.bottomButton.isHidden = !isConnectedState
                }
            }
            .store(in: &cancellables)
    }
}

#Preview {
    SuperVipPromoViewController()
}
