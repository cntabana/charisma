<?php
$model = new Traitement;
$this->breadcrumbs=array(
	'Traitements',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
    $('.search-form').slideToggle('fast');
    return false;
});
$('.search-form form').submit(function(){
    $.fn.yiiGridView.update('traitement-grid', {
        data: $(this).serialize()
    });
    return false;
});
");

?>

<h1>Traitements</h1>
<hr />

<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'linkOptions'=>array()),
                array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Search', 'icon'=>'icon-search', 'url'=>'#', 'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>



<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->


<?php 
$type = array(
      array('value' => 1, 'text' => 'Analyse'),
      array('value' => 2, 'text' => 'Traitement'),
      
    );

$transfer = array(
      array('value' => 0, 'text' => 'No'),
      array('value' => 1, 'text' => 'Yes'),
      
    );

$this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'traitement-grid',
	'dataProvider'=>$model->search(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
	'columns'=>array(
		'id',
		array( 
            'class' => 'editable.EditableColumn',
            'name' => 'medical_act',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('traitement/UpdateBooster'),
                'placement' => 'right',
            )
          ),
		'idservice',
		array( 
                        'class' => 'editable.EditableColumn',
                        'name' => 'type',
                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('traitement/updateBooster'),
                           'source'=>$type,
                      
                          
              ),
          ),
		array( 
                        'class' => 'editable.EditableColumn',
                        'name' => 'transfer',
                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('traitement/updateBooster'),
                           'source'=>$transfer,
                      
                          
              ),
          ),
       array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
			'template' => '{view} {update} {delete}',
			'buttons' => array(
			      'view' => array(
					'label'=> 'View',
					'options'=>array(
						'class'=>'btn btn-small view'
					)
				),	
                              'update' => array(
					'label'=> 'Update',
					'options'=>array(
						'class'=>'btn btn-small update'
					)
				),
				'delete' => array(
					'label'=> 'Delete',
					'options'=>array(
						'class'=>'btn btn-small delete'
					)
				)
			),
            'htmlOptions'=>array('style'=>'width: 115px'),
           )
	),
)); ?>

